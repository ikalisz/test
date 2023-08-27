RegisterNetEvent('l2s-projector:server:project-start')
RegisterNetEvent('l2s-projector:server:project-stop')
on('l2s-projector:server:project-start', function (event) {
  emitNet('l2s-projector:client:project-start', -1, event)
})

on('l2s-projector:server:project-stop', function () {
  emitNet('l2s-projector:client:project-stop', -1)
})
