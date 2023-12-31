local Locales = {
    ['place_sapling'] = 'Tohum Ekiliyor',
	['canceled'] = 'İptal Edildi..',
	['place_or_cancel'] = '[E] - Bitkiyi Yerleştir / [G] - İptal',
	['missing_water'] = 'Bitkiyi sulamak için bir şeyi kaçırıyorsun..',
	['missing_fertilizer'] = 'Gübren Yok.',
	['missing_mseed'] = 'Erkek Tohumun Yok!',
	['clear_plant'] = 'Temizleniyor.',
	['harvesting_plant'] = 'Toplanıyor',
	['watering_plant'] = 'Su Ekleniyor.',
	['fertilizing_plant'] = 'Bitkiye Gübre Ekleniyor',
	['adding_male_seed'] = 'Erkek tohum ekleniyor..',
	['check_plant'] = 'Kontrol Et',
	['plant_header'] = 'Kenevir Bitkisi',
	['esc_to_close'] = 'ESC veya Kapatmak İçin Tıklayın',
	['watered_plant'] = 'Bitki Sulandı',
	['fertilizer_added'] = 'Bitkiye gübre kattınız..',
	['male_seed_added'] = 'Bitkiye bir erkek tohum eklediniz..',
	['processing_branch'] = 'İşlem şubesi',
	['ready_for_harvest'] = 'Bu bitki hasat için hazır!',
	['clear_plant_header'] = 'Berrak Bitki',
	['clear_plant_text'] = 'Bitki Soldu',
	['destroy_plant'] = 'Bitkiyi Yok Et',
	['add_water'] = 'Bu bitkiye su ekleyin',
	['add_fertilizer'] = 'Bitkiye gübre ekleyin',
	['add_mseed'] = 'Erkek Tohum Ekle',
	['not_enough_dryweed'] = 'Yeterince kuru otunuz yok...',
	['packaging_weed'] = 'Paketleniyor...',
	['package_goods'] = 'Paket Ürünler',
	['grab_packaged_goods'] = 'Paketi Yakala',
	['start_delivering'] = 'Teslimata Başla',
	['stop_delivering'] = 'Teslimatı Durdur',
	['dont_have_anything'] = 'Benim için paketleyecek bir şeyin yok..',
	['handing_over_weed'] = 'Paketlenmiş otları teslim et!.',
	['wait_closeby'] = 'Senin için paketlemeyi bitirene kadar yakında bekle',
	['still_waiting'] = 'Daha bitirmedim!',
	['moved_too_far'] = 'Fazla uzaklaştın',
	['deliver_package'] = 'Paketi Teslim Et',
	['weedrun_clockout'] = 'Paketleri teslim etmeyi bıraktınız..',
	['weedrun_hasnopackage'] = 'Peki sen aslında bana ne vermek istiyorsun..?',
	['weedrun_delivery_blip'] = 'Weedrun - Teslimat',
	['weedrun_delivery_title'] = 'Mevcut',
	['weedrun_delivery_godropoff'] = 'İnişe doğru yol alın..',
	['weedrun_delivery_makedropoff'] = 'Teslimatı Yap',
	['weedrun_delivery_waitfornew'] = 'Yeni lokasyonu bekle',
	['weedrun_delivery_success'] = 'Teslimat iyiydi, bir sonraki teslimatla güncelleneceksiniz.'
}

function _U(entry)
	return Locales[entry] 
end