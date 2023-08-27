exports('KoseTut', function(item)
    return Config.KoseTut[item]
end)

exports('BlackMarket', function(item)
    return Config.BlackMarket[item]
end)

exports('itemPrice', function(item)
    return Config.itemPrice[item]
end)

exports('merryWeatherPrice', function(item)
    return Config.merryWeatherPrice[item]
end)

exports('policePrice', function(item)
    return Config.policePrice[item]
end)

exports('ambulancePrice', function(item)
    return Config.ambulancePrice[item]
end)

exports('esxkrshop', function(item)
    return Config.esxkrshop[item]
end)

exports('uber', function(item)
    return Config.uber[item]
end)

exports('Hacker', function(item)
    return Config.Hacker[item]
end)

local isim = {"Aaliyah","Aileen" ,"Alana" ,"Alanis" ,"Alanna" ,"Alayna" ,"Aleah" ,"Alejandra" ,"Alena" ,"Alexia" ,"Alexis" ,"Alexus" ,"Alexys" ,"Alia" ,"Alice" ,"Alicia" ,"Alina" ,"Alisa" ,"Alisha" ,"Allyssa" ,"Alma" ,"Amara" ,"Amari" ,"Amaya" ,"Amber" ,"Amelia" ,"America" ,"Amina" ,"Amira" ,"Amy" ,"Amya" ,"Ana" ,"Anabel" ,"Anahi" ,"Anais" ,"Anastasia" ,"Anaya" ,"Andrea" ,"Angel" ,"Angela" ,"Angelica" ,"Angelina" ,"Angeline" ,"Angelique" ,"Angie" ,"Anika" ,"Anissa" ,"Anita" ,"Aniya" ,"Aniyah" ,"Anjali" ,"Ann" ,"Anna" ,"Annabel" ,"Kayden" ,"Keagan" ,"Keanu" ,"Keaton" ,"Keegan" ,"Keenan" ,"Annalise" ,"Anne" ,"Annette" ,"Annie" ,"Annika" ,"Ansley" ,"Antonia" ,"Anya" ,"April" ,"Araceli" ,"Aracely" ,"Arely" ,"Aria" ,"Ariana" ,"Arianna" ,"Ariel" ,"Arielle" ,"Arlene" ,"Armani" ,"Aryanna" ,"Ashanti" ,"Ashlee" ,"Ashleigh" ,"Ashley" ,"Ashly" ,"Ashlyn" ,"Ashlynn" ,"Ashton" ,"Ashtyn" ,"Asia" ,"Aspen" ,"Astrid" ,"Athena" ,"Jamil" ,"Jamir" ,"Jamison" ,"Jan" ,"Jaquan" ,"Jaquez" ,"Jared" ,"Jaren" ,"Jarod" ,"Jaron" ,"Aubree" ,"Aubrey" ,"Aubrie" ,"Audrey" ,"Aurora" ,"Beatriz" ,"Belen" ,"Bella" ,"Berenice" ,"Bethany","Breonna" ,"Isai" ,"Isaiah" ,"Isaias" ,"Isiah" ,"Israel" ,"Issac" ,"Ivan" ,"Bria" ,"Briana" ,"Brianna" ,"Brianne" ,"Bridget" ,"Brielle" ,"Brionna" ,"Brisa" ,"Britney" ,"Brittany" ,"Brittney" ,"Brooke" ,"Brooklyn" ,"Brooklynn" ,"Bryana" ,"Bryanna" ,"Brynn" ,"Cadence" ,"Caitlin" ,"Caitlyn" ,"Cali" ,"Calista","Candace" ,"Candice" ,"Cara" ,"Carina" ,"Carissa" ,"Carla" ,"Carlee" ,"Carley" ,"Carli" ,"Carlie" ,"Gregory" ,"Greyson" ,"Griffin" ,"Guadalupe" ,"Guillermo" ,"Gunnar" ,"Gunner" ,"Gustavo" ,"Guy" ,"Carly" ,"Carmen" ,"Carol" ,"Carolina" ,"Caroline" ,"Carolyn" ,"Carrie" ,"Carson" ,"Casandra" ,"Casey" ,"Cassandra" ,"Cassidy" ,"Cassie" ,"Catalina" ,"Catherine" ,"Cayla" ,"Cecelia","Chasity" ,"Chaya" ,"Chelsea" ,"Chelsey" ,"Cheyanne" ,"Francis" ,"Francisco" ,"Frank" ,"Frankie" ,"Franklin" ,"Fred" ,"Freddie" ,"Cheyenne" ,"Chloe" ,"Christa" ,"Christian" ,"Christiana" ,"Christina" ,"Christine" ,"Christy" ,"Ciara" ,"Ciera" ,"Cierra" ,"Cindy" ,"Citlali" ,"Claire" ,"Clara" ,"Clare" ,"Clarissa" ,"Claudia" ,"Colleen" ,"Cora" ,"Corinne" ,"Courtney" ,"Cristal" ,"Cristina","Dalia" ,"Damaris" ,"Dana" ,"Dania" ,"Daniela" ,"Daniella" ,"Eliezer" ,"Elijah" ,"Eliseo" ,"Elisha" ,"Elliot" ,"Elliott","Deanna" ,"Deasia" ,"Deborah" ,"Deja","Destini" ,"Destiny" ,"Devin" ,"Devon" ,"Devyn" ,"Edith" ,"Eileen" ,"Elaina" ,"Elaine" ,"Eleanor" ,"Elena" ,"Eliana" ,"Elisa" ,"Elisabeth" ,"Elise" ,"Elissa" ,"Eliza" ,"Elizabeth" ,"Ella" ,"Elle" ,"Ellen" ,"Ellie" ,"Elsa" ,"Elyse" ,"Elyssa" ,"Emely" ,"Emerson" ,"Emilee" ,"Emilia" ,"Emilie" ,"Emily" ,"Emma" ,"Emmalee" ,"Erica" ,"Ericka" ,"Erika" ,"Erin" ,"Esmeralda" ,"Esperanza" ,"Essence" ,"Estefani" ,"Evelin" ,"Evelyn" ,"Fabiola" ,"Faith" ,"Fatima" ,"Felicia" ,"Felicity" ,"Fernanda" ,"Fiona" ,"Gabrielle" ,"Galilea" ,"Genesis" ,"Genevieve" ,"Georgia" ,"Gia" ,"Giana" ,"Gianna" ,"Gillian" ,"Gina" ,"Giovanna" ,"Giselle" ,"Gisselle" ,"Gloria" ,"Grace" ,"Gracie" ,"Graciela" ,"Greta" ,"Gretchen","Hailie" ,"Haleigh" ,"Haley" ,"Halie" ,"Halle","Haylee" ,"Hayley" ,"Haylie" ,"Hazel" ,"Heather" ,"Heaven" ,"Heidi" ,"Helen" ,"Helena" ,"Holly" ,"Hope" ,"Hunter" ,"Iliana" ,"Imani" ,"Isabell" ,"Isabella" ,"Isabelle" ,"Isis" ,"Itzel" ,"Ivy" ,"Iyana" ,"Iyanna" ,"Izabella","Jaiden" ,"Jaidyn" ,"Jailyn" ,"Jaime" ,"Jakayla" ,"Jaliyah","Janae" ,"Jane" ,"Janelle" ,"Janessa" ,"Janet" ,"Jaycee" ,"Jayda" ,"Jayde" ,"Jayden" ,"Jayla" ,"Jaylene" ,"Jaylin" ,"Jaylyn" ,"Jaylynn" ,"Jazlyn" ,"Jazmin" ,"Jazmine" ,"Jazmyn" ,"Jazmyne" ,"Jeanette" ,"Jena","Jessie" ,"Jewel" ,"Jillian" ,"Jimena" ,"Joana" ,"Joanna" ,"Josie" ,"Joslyn" ,"Journey" ,"Joy" ,"Joyce" ,"Judith" ,"Julia" ,"Juliana" ,"Julianna" ,"Julianne" ,"Julie" ,"Juliet" ,"Juliette" ,"Julissa" ,"Justice" ,"Justine" ,"Kacie" ,"Kaela" ,"Kaelyn" ,"Kaia" ,"Kaila" ,"Kailee" ,"Kailey" ,"Kailyn" ,"Kaitlin" ,"Kaitlyn" ,"Kaitlynn" ,"Kaiya" ,"Kaleigh" ,"Kaley" ,"Kali" ,"Kaliyah" ,"Kallie" ,"Kalyn" ,"Kamryn" ,"Kara" ,"Karen" ,"Kari" ,"Lesley" ,"Leslie" ,"Madison" ,"Madisyn" ,"Madyson" ,"Maegan" ,"Maeve" ,"Magdalena" ,"Maggie" ,"Maia" ,"Noelia" ,"Noelle" ,"Noemi" ,"Payton" ,"Penelope" ,"Perla" ,"Peyton" ,"Phoebe" ,"Piper" ,"Dangelo" ,"Daniel" ,"Danny" ,"Dante" ,"Daquan" ,"Darian" ,"Darien" ,"Darin" ,"Precious" ,"Presley" ,"Princess" ,"Priscila" ,"Reanna" ,"Rebeca" ,"Rebecca" ,"Rebekah" ,"Reese" ,"Regan" ,"Regina" ,"Reilly" ,"Reina" ,"Renee" ,"Reyna" ,"Shelby" ,"Shirley" ,"Shreya" ,"Shyann" ,"Shyanne" ,"Sidney" ,"Sienna" ,"Sierra" ,"Tiara" ,"Tierra" ,"Tiffany" ,"Tina","Zoe" ,"Zoey" ,"Aden" ,"Aditya" ,"Adrien" ,"Agustin","Brandon" ,"Braulio" ,"Braxton" ,"Brayan" ,"Brayden" ,"Calvin" ,"Camden" ,"Cameron" ,"Camren" ,"Camron" ,"Carl" ,"Carlo" ,"Leon","Lewis" ,"Liam" ,"Lincoln" ,"Lisandro" ,"Logan"}
local soyIsim = {"Adams" ,"Allen" ,"Anderson" ,"Atkins" ,"Baker" ,"Barnes" ,"Bell" ,"Bennett" ,"Berry" ,"Bishop" ,"Black" ,"Brown" ,"Burns" ,"Campbell" ,"Carter" ,"Clark" ,"Collins" ,"Cook"  ,"Cooke" ,"Cooper" ,"Cox" ,"Davidson" ,"Davies" ,"Davis" ,"Dawson" ,"Edwards" ,"Evans" ,"Fleming" ,"Forester" ,"Foster" ,"Fox" ,"Gardener" ,"Gibb"  ,"Gibbs" ,"Gray" ,"Green" ,"Hall" ,"Hamilton" ,"Harris" ,"Henderson" ,"Hill" ,"Holmes" ,"Hughes" ,"Hunt" ,"Jackson" ,"Johnson" ,"Jones" ,"Kelly" ,"King" ,"Lee" ,"Lewis" ,"Marshall" ,"Matthews" ,"McDonald" ,"Miller" ,"Mitchell" ,"Moore" ,"Morris" ,"Morrison" ,"Murphy" ,"Murray" ,"Nicholson","Osborne"	 ,"Parker" ,"Paters" ,"Patterson" ,"Peterson" ,"Phillips" ,"Philips" ,"Porter" ,"Powell" ,"Reid"  ,"Reed" ,"Richards" ,"Richardson" ,"Roberts" ,"Robinson" ,"Rogers" ,"Russell" ,"Sanders" ,"Scott" ,"Shaw" ,"Simpson" ,"Smith" ,"Smyth" ,"Snyder" ,"Stephens" ,"Stewart" ,"Summers" ,"Taylor" ,"Thomas" ,"Thompson" ,"Turner" ,"Walker" ,"Wallace" ,"Ward" ,"Warren" ,"Webster" ,"White" ,"Williams" ,"Wilson" ,"Wood" ,"Wright"}

exports('randomName', function()
    local firstName = math.random(1, #isim)
    local lastName = math.random(1, #soyIsim)
    return isim[firstName] .. " " .. soyIsim[lastName]
end)