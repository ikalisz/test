const projectorPos = [439.4834606, -987.31636962, 36.880146179] // MRPD board

async function loadScaleform(scaleform) {
  let scaleformHandle = RequestScaleformMovie(scaleform)

  return new Promise((resolve) => {
    const interval = setInterval(() => {
      if (HasScaleformMovieLoaded(scaleformHandle)) {
        clearInterval(interval)
        resolve(scaleformHandle)
      } else {
        scaleformHandle = RequestScaleformMovie(scaleform)
      }
    }, 0)
  })
}

const url = 'https://i.imgur.com/Jhh0Apl.png' // Lighthouse eft map :)
const scale = 0.1
const sfName = 'generic_texture_renderer'

const width = 1550
const height = 960

let sfHandle = null
let txdHasBeenSet = false
let duiObj = null
let currentUrl = null
let isPlaying = false
let ourlink = null
let slidesnumber = 1

setTick(async () => {
  if (sfHandle !== null && !txdHasBeenSet) {
    PushScaleformMovieFunction(sfHandle, 'SET_TEXTURE')

    PushScaleformMovieMethodParameterString('meows') // txd
    PushScaleformMovieMethodParameterString('woof') // txn

    PushScaleformMovieFunctionParameterInt(0) // x
    PushScaleformMovieFunctionParameterInt(0) // y
    PushScaleformMovieFunctionParameterInt(width)
    PushScaleformMovieFunctionParameterInt(height)

    PopScaleformMovieFunctionVoid()

    txdHasBeenSet = true
  }

  if (currentUrl) {
    const playerCoords = GetEntityCoords(PlayerPedId())
    if (
      GetDistanceBetweenCoords(
        playerCoords[0],
        playerCoords[1],
        playerCoords[2],
        projectorPos[0],
        projectorPos[1],
        projectorPos[2],
      ) <= 12.0
    ) {
      if (!isPlaying) {
        await taskPlayUrl(currentUrl)
      }
    } else {
      CleanupDUI()
    }
  }
  if (sfHandle !== null && HasScaleformMovieLoaded(sfHandle)) {
    DrawScaleformMovie_3dNonAdditive(
      sfHandle,
      projectorPos[0],
      projectorPos[1],
      projectorPos[2],
      0,
      0,
      -90,
      2,
      2,
      2,
      scale * 1,
      scale * (9 / 16),
      1,
      2,
    )
  }
})




on('l2s-projector:client:project', async () => {
  const keyboard = await exports['qb-input'].ShowInput({
    header: 'Projector',
    inputs: [
      {
        text: 'Load URL',
        name: 'link',
        type: 'text',
        isRequired: true,
        default: '',
      },
      {
        text: 'select ',
        name: 'linktype',
        type: 'select',
        isRequired: true,
        default: '',
        options: [
          { value: "door", text: 'Youtube Video' },
          { value: "slides", text: 'Google Sunumu' },
          { value: "double", text: 'Genel Link' },
        ]
      },
    ],
  })
  if (keyboard) {
    let videurell = keyboard.link
    if (keyboard.linktype == 'door') {
      var regExp = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
      var match = videurell.match(regExp);
      // console.log(match[2])
      if (match[2]) {
        emitNet('l2s-projector:server:project-start', 'https://www.youtube.com/embed/' + match[2] + '?autoplay=1')
      }
    } else if (keyboard.linktype == 'slides') {
      ourlink = keyboard.link
      emitNet('l2s-projector:server:project-start', keyboard.link + '/embed?slide=' + slidesnumber + '')
    } else {
      emitNet('l2s-projector:server:project-start', keyboard.link)
    }
  }

})

on('l2s-projector:client:next', async () => {
  if (ourlink) {
    slidesnumber = slidesnumber + 1
    emitNet('l2s-projector:server:project-start', ourlink + '/embed?slide=' + slidesnumber + '')
  }
})

on('l2s-projector:client:previous', async () => {
  if (ourlink) {
    if (slidesnumber > 0) {
      slidesnumber = slidesnumber - 1
      emitNet('l2s-projector:server:project-start', ourlink + '/embed?slide=' + slidesnumber + '')
    }
  }
})

on('l2s-projector:client:project-clear', () => {
  emitNet('l2s-projector:server:project-stop')
})

RegisterNetEvent('l2s-projector:client:project-start')
RegisterNetEvent('l2s-projector:client:project-stop')
on('l2s-projector:client:project-start', async (link) => {
  if (currentUrl) CleanupDUI()
  currentUrl = link

  await taskPlayUrl(link)
})
on('l2s-projector:client:project-stop', () => {
  currentUrl = null
  ourlink = null
  slidesnumber = 1
  CleanupDUI()
})

const taskPlayUrl = async (link) => {
  isPlaying = true
  sfHandle = await loadScaleform(sfName)

  runtimeTxd = 'meows'

  const txd = CreateRuntimeTxd('meows')
  duiObj = CreateDui(link, width, height)
  const dui = GetDuiHandle(duiObj)
  const tx = CreateRuntimeTextureFromDuiHandle(txd, 'woof', dui)
}

on('QBCore:Client:OnPlayerLoaded', () => {
  SetupQbTarget()
})

on('onClientResourceStart', async (resName) => {
  if (resName === GetCurrentResourceName()) {
    SetupQbTarget()
  }
})

on('onResourceStop', (resName) => {
  if (resName === GetCurrentResourceName()) {
    CleanupDUI()
  }
})

const SetupQbTarget = () => {
  exports['qb-target'].AddTargetModel(GetHashKey('p_planning_board_02'), {
    options: [
      {
        event: 'l2s-projector:client:project',
        icon: 'fas fa-circle',
        label: 'Use Projector',
      },
      {
        event: 'l2s-projector:client:project-clear',
        icon: 'fas fa-power-off',
        label: 'Close',
      },
      {
        event: 'l2s-projector:client:next',
        icon: 'fas fa-caret-right',
        label: 'Next',
      },
      {
        event: 'l2s-projector:client:previous',
        icon: 'fas fa-caret-left',
        label: 'Previous',
      },
    ],
    job: 'police',
    distance: 2.0,
  })
}

const CleanupDUI = () => {
  if (duiObj) {
    DestroyDui(duiObj)
    SetScaleformMovieAsNoLongerNeeded(0)
    duiObj = null
    txdHasBeenSet = false
    sfHandle = null
    isPlaying = false
  }
}