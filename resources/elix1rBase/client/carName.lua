local Vehicles = {
    {label = 'Polis Victoria', spawnName = 'polvic'},
    {label = 'Mazda FN RX7', spawnName = 'fnfrx7'}

}

Citizen.CreateThread(function()
    for num,vehicle in ipairs(Vehicles) do
        AddTextEntryByHash(GetHashKey(vehicle.spawnName), vehicle.label)
    end
end)

function AddTextEntry(key, value)
	Citizen.InvokeNative(`ADD_TEXT_ENTRY`, key, value)
end





Citizen.CreateThread(function()
    AddTextEntry('dilettante2', 'Driving Test Tool')
    AddTextEntry('npolvette', 'Police Corvette')
    AddTextEntry('npolstang', 'Police Mustang')
    AddTextEntry('npolchal', 'Police Challenger')
    AddTextEntry('panamera17turbo', 'Porsche Panamera')
    AddTextEntry('m6f13', 'BMW M6')
    AddTextEntry('bmws', 'BMW s1000RR')
    AddTextEntry('911turbos', 'Porsche 911T')
    AddTextEntry('vantage', 'Aston Martin Vantage')
    AddTextEntry('viper', 'Dodge Viper')
    AddTextEntry('rmodgt63', 'Mercedes AMG GT63s')
    AddTextEntry('amggt', 'AMG GT')
    AddTextEntry('c7', 'Chevrolet CorvetteC7')
    AddTextEntry('i8', 'BMW i8')
    AddTextEntry('tuscani', 'Hyundai Tuscani')
    AddTextEntry('npolvic', 'Police Victoria')
    AddTextEntry('rs5', 'Audi RS5')
    AddTextEntry('rrst', 'Range Rover Vogue')
    AddTextEntry('sgt500', 'Mustang GT500')
    AddTextEntry('bmci', 'BMW M5')
    AddTextEntry('69charger', 'Dodge Charger69')
    AddTextEntry('mb300sl', 'Mercedes-Benz 300SL')
    AddTextEntry('16challenger', 'Dodge Challenger16')
    AddTextEntry('audirs6tk', 'Audi RS6')
    AddTextEntry('s500w222', 'Mercedes S500')
    AddTextEntry('a8audi', 'Audi A8')
    AddTextEntry('evo9', 'Mitshubishi Lancer EVO9')
    AddTextEntry('2013rs7', 'Audi RS7')
    AddTextEntry('subwrx', 'Subaru WRX')
    AddTextEntry('m3e30', 'BMW M3')
    AddTextEntry('honcrx91', 'Honda CRX91')
    AddTextEntry('civic', 'Honda Civic99')
    AddTextEntry('a45amg', 'Mercedes AMG A45')
    AddTextEntry('africat', 'Honda CRF1000L')
    AddTextEntry('bmwe65', 'BMW E65')
    AddTextEntry('16charger', 'Dodge Charger16')
    AddTextEntry('amarok', 'VolksWagen Amarok')
    AddTextEntry('nspeedo', 'Vapid Speedo')
    AddTextEntry('yfiat595ssb', 'Fiat Abarth 595')
    AddTextEntry('g_xlcr', 'Harley XLCR')
    AddTextEntry('gpz1100', 'Kawasaki GP Z1100')
    AddTextEntry('z1000a1', 'Kawasaki Z1000 A1')
    AddTextEntry('g_900mhr', 'Ducati 900 MHR')
    AddTextEntry('g_900ss', 'Ducati 900 SS')
    AddTextEntry('f100', 'Ford F100')
    AddTextEntry('f150', 'Ford Raptor 12')
    AddTextEntry('fatboy', 'Harley Vintage')
    AddTextEntry('yfiat595ssa', 'Fiat 500')
    AddTextEntry('mk1rabbit', 'Golf MK1')
    AddTextEntry('911rwb', 'Porsche 911RWB')
    AddTextEntry('c7', 'Corvette C7')
    AddTextEntry('mustang19', '19 Mustang Boss')
    AddTextEntry('er34', 'R34 Skyline')
    AddTextEntry('rapide', 'Aston Martin Rapide')
    AddTextEntry('granlb', 'Maserati GranTurismo')
    AddTextEntry('focusrs', 'Ford FocusRS')
    AddTextEntry('fugitive3', 'Fugitive Custom')
    AddTextEntry('nc1', 'NSX')
    AddTextEntry('civicek9rb', 'Type-R')
    AddTextEntry('ast', 'Aston Martin Vanquish')
    AddTextEntry('ninefjd', 'Ninef JD')
    AddTextEntry('pentrogpr2', 'Pentro GPR2')
    AddTextEntry('crocotogt', 'Porsche Cayenne')
    AddTextEntry('sentigpr', 'Sentinel Custom')
    AddTextEntry('fk8', 'Honda Civic')
    AddTextEntry('rs5r', 'Audi RS5')
    AddTextEntry('urus', 'Lamborghini Urus')
    AddTextEntry('bdragon', 'Bentley GT')
    AddTextEntry('gtrc', 'Mercedes GT')
    AddTextEntry('m4', 'BMW M4')
    AddTextEntry('m235', 'BMW M2')
    AddTextEntry('z32', 'Fairlady')
    AddTextEntry('komodofr', 'Komodo Custom')
    AddTextEntry('beetle74', 'Volkswagen Beetle 74')
    AddTextEntry('aoka', 'Lada Oka')
    AddTextEntry('fz50', 'FZ 50')
    AddTextEntry('ak99', 'Lada Samara')
    AddTextEntry('eclipse', 'Eclipse')
    AddTextEntry('skyline', 'Skyline')
    AddTextEntry('370z', 'Nissan 370Z')
    AddTextEntry('tampa3', 'Drift Tampa')
    AddTextEntry('yosemite6str', 'Drift Yosemite')
    AddTextEntry('demon', 'Dodge Challenger')
    AddTextEntry('gtx', 'Plymouth GTX 71')
    AddTextEntry('kart', 'Si-Kart')
    AddTextEntry('r820', 'Audi R8')
    AddTextEntry('nh2r', 'Kawasaki Ninja H2R')
    AddTextEntry('mgt', 'Ford Mustang GT15')
    AddTextEntry('gtr', 'Nissan GTR 17')
    AddTextEntry('lp700r', 'Lamborghini Aventador 13')
    AddTextEntry('720s', 'McLaren 720s 17')
    AddTextEntry('18performante', 'Lamborghini Huracan')
    AddTextEntry('gt17', 'Ford GT 17')
    AddTextEntry('14charger', 'Polis Charger')
    AddTextEntry('11cvpi', 'Polis Crown Victoria')
    AddTextEntry('2015polstang', 'HSU Mustang GT')
    AddTextEntry('emsroamer', 'EMS SUV')
    AddTextEntry('emsnspeedo', 'EMS Ambulans')
    AddTextEntry('polp1', 'HSU McLaren P1')
    AddTextEntry('pol718', 'HSU Porsche 718')
    AddTextEntry('polchar', 'Police Charger')
    AddTextEntry('polraptor', 'Police Raptor')
    AddTextEntry('poltah', 'Police Tahoe')
    AddTextEntry('poltaurus', 'Police Taurus')
    AddTextEntry('polvic', 'Police Victoria')
    AddTextEntry('polvic2', 'Police Victoria V2')
    AddTextEntry('polnspeedo', 'Police Transporter')
    AddTextEntry('mclarenpd', 'HSU McLaren V2')
    AddTextEntry('chargerpol', 'HSU Police Charger')
    AddTextEntry('polgs350', 'HSU Police Lexus')
    AddTextEntry('ucballer', 'Civil Baller')
    AddTextEntry('ucbanshee', 'Civil Banshee')
    AddTextEntry('ucbuffalo', 'Civil Buffalo')
    AddTextEntry('uccomet', 'Civil Comet')
    AddTextEntry('uccoquette', 'Civil Coquette')
    AddTextEntry('ucprimo', 'Civil Primo')
    AddTextEntry('ucrancher', 'Civil Rancher')
    AddTextEntry('ucwashington', 'Civil Washington')
    AddTextEntry('polschafter3', 'Civil Schafter')
    AddTextEntry('panamera17turbo', 'Porsche Panamera')
    AddTextEntry('m6f13', 'BMW M6')
    AddTextEntry('bmws', 'BMW s1000RR')
    AddTextEntry('911turbos', 'Porsche 911T')
    AddTextEntry('vantage', 'Aston Martin Vantage')
    AddTextEntry('viper', 'Dodge Viper')
    AddTextEntry('rmodgt63', 'Mercedes AMG GT63s')
    AddTextEntry('amggt', 'AMG GT')
    AddTextEntry('c7', 'Chevrolet CorvetteC7')
    AddTextEntry('i8', 'BMW i8')
    AddTextEntry('tuscani', 'Hyundai Tuscani')
    AddTextEntry('rs5', 'Audi RS5')
    AddTextEntry('rrst', 'Range Rover Vogue')
    AddTextEntry('sgt500', 'Mustang GT500')
    AddTextEntry('bmci', 'BMW M5')
    AddTextEntry('69charger', 'Dodge Charger69')
    AddTextEntry('mb300sl', 'Mercedes-Benz 300SL')
    AddTextEntry('16challenger', 'Dodge Challenger16')
    AddTextEntry('audirs6tk', 'Audi RS6')
    AddTextEntry('s500w222', 'Mercedes S500')
    AddTextEntry('a8audi', 'Audi A8')
    AddTextEntry('evo9', 'Mitshubishi Lancer EVO9')
    AddTextEntry('2013rs7', 'Audi RS7')
    AddTextEntry('subwrx', 'Subaru WRX')
    AddTextEntry('m3e30', 'BMW M3')
    AddTextEntry('honcrx91', 'Honda CRX91')
    AddTextEntry('civic', 'Honda Civic99')
    AddTextEntry('a45amg', 'Mercedes AMG A45')
    AddTextEntry('africat', 'Honda CRF1000L')
    AddTextEntry('bmwe65', 'BMW E65')
    AddTextEntry('16charger', 'Dodge Charger16')
    AddTextEntry('amarok', 'VolksWagen Amarok')
    AddTextEntry('nspeedo', 'Vapid Speedo')
    AddTextEntry('yfiat595ssb', 'Fiat Abarth 595')
    AddTextEntry('g_xlcr', 'Harley XLCR')
    AddTextEntry('gpz1100', 'Kawasaki GP Z1100')
    AddTextEntry('z1000a1', 'Kawasaki Z1000 A1')
    AddTextEntry('g_900mhr', 'Ducati 900 MHR')
    AddTextEntry('g_900ss', 'Ducati 900 SS')
    AddTextEntry('f100', 'Ford F100')
    AddTextEntry('f150', 'Ford Raptor 12')
    AddTextEntry('fatboy', 'Harley Vintage')
    AddTextEntry('yfiat595ssa', 'Fiat 500')
    AddTextEntry('mk1rabbit', 'Golf MK1')
    AddTextEntry('911rwb', 'Porsche 911RWB')
    AddTextEntry('c7', 'Corvette C7')
    AddTextEntry('mustang19', '19 Mustang Boss')
    AddTextEntry('er34', 'R34 Skyline')
    AddTextEntry('rapide', 'Aston Martin Rapide')
    AddTextEntry('granlb', 'Maserati GranTurismo')
    AddTextEntry('focusrs', 'Ford FocusRS')
    AddTextEntry('fugitive3', 'Fugitive Custom')
    AddTextEntry('nc1', 'NSX')
    AddTextEntry('civicek9rb', 'Type-R')
    AddTextEntry('ast', 'Aston Martin Vanquish')
    AddTextEntry('ninefjd', 'Ninef JD')
    AddTextEntry('pentrogpr2', 'Pentro GPR2')
    AddTextEntry('crocotogt', 'Porsche Cayenne')
    AddTextEntry('sentigpr', 'Sentinel Custom')
    AddTextEntry('fk8', 'Honda Civic')
    AddTextEntry('rs5r', 'Audi RS5')
    AddTextEntry('urus', 'Lamborghini Urus')
    AddTextEntry('bdragon', 'Bentley GT')
    AddTextEntry('gtrc', 'Mercedes GT')
    AddTextEntry('m4', 'BMW M4')
    AddTextEntry('m235', 'BMW M2')
    AddTextEntry('z32', 'Fairlady')
    AddTextEntry('komodofr', 'Komodo Custom')
    AddTextEntry('beetle74', 'Volkswagen Beetle 74')
    AddTextEntry('aoka', 'Lada Oka')
    AddTextEntry('fz50', 'FZ 50')
    AddTextEntry('ak99', 'Lada Samara')
    AddTextEntry('eclipse', 'Eclipse')
    AddTextEntry('skyline', 'Skyline')
    AddTextEntry('370z', 'Nissan 370Z')
    AddTextEntry('tampa3', 'Drift Tampa')
    AddTextEntry('yosemite6str', 'Drift Yosemite')
    AddTextEntry('demon', 'Dodge Challenger')
    AddTextEntry('gtx', 'Plymouth GTX 71')
    AddTextEntry('kart', 'Si-Kart')
    AddTextEntry('r820', 'Audi R8')
    AddTextEntry('nh2r', 'Kawasaki Ninja H2R')
    AddTextEntry('mgt', 'Ford Mustang GT15')
    AddTextEntry('gtr', 'Nissan GTR 17')
    AddTextEntry('lp700r', 'Lamborghini Aventador 13')
    AddTextEntry('720s', 'McLaren 720s 17')
    AddTextEntry('18performante', 'Lamborghini Huracan')
    AddTextEntry('gt17', 'Ford GT 17')
    AddTextEntry('14charger', 'Polis Charger')
    AddTextEntry('11cvpi', 'Polis Crown Victoria')
    AddTextEntry('2015polstang', 'HSU Mustang GT')
    AddTextEntry('emsroamer', 'EMS SUV')
    AddTextEntry('emsnspeedo', 'EMS Ambulans')
    AddTextEntry('polp1', 'Police McLaren (HSU)[3]')
    AddTextEntry('pol718', 'Police Porsche (HSU)[2]')
    AddTextEntry('polchar', 'Police Charger')
    AddTextEntry('polraptor', 'Police Raptor')
    AddTextEntry('poltah', 'Police Tahoe')
    AddTextEntry('poltaurus', 'Police Taurus')
    AddTextEntry('npolvic', 'Police Victoria')
    AddTextEntry('polvic2', 'Police Victoria V2')
    AddTextEntry('npolvette', 'Police Corvette')
    AddTextEntry('npolstang', 'Police Mustang')
    AddTextEntry('npolchal', 'Police Challenger ')
    AddTextEntry('polnspeedo', 'Police Transporter')
    AddTextEntry('mclarenpd', 'Police McLaren V2')
    AddTextEntry('chargerpol', 'Police Charger ')
    AddTextEntry('polgs350', 'HSU Police Lexus')
    AddTextEntry('ucballer', 'Civil Baller')
    AddTextEntry('ucbanshee', 'Civil Banshee')
    AddTextEntry('ucbuffalo', 'Civil Buffalo')
    AddTextEntry('uccomet', 'Civil Comet')
    AddTextEntry('uccoquette', 'Civil Coquette')
    AddTextEntry('ucprimo', 'Civil Primo')
    AddTextEntry('ucrancher', 'Civil Rancher')
    AddTextEntry('ucwashington', 'Civil Washington')
    AddTextEntry('polschafter3', 'Civil Schafter')
    AddTextEntry('polfegway', 'Police Small')
    AddTextEntry('npolmm', 'Police Motor')
    AddTextEntry('npolmm', 'Police Motor')
end)