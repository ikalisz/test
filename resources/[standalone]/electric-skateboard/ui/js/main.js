window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        if (event.data.onBoard) {
            $("#board-container").fadeOut(200, function() {
                $(this).html(`
                    <div class="key-line">
                        <div class="key">[G]</div> 
                        <div class="key-ex">KAYKAYDAN İN</div>
                    </div>
                    <div class="key-line">
                        <div class="key">[E]</div> 
                        <div class="key-ex">KAYKAYI YERDEN AL</div>
                    </div>
                    <div class="key-line">
                        <div class="key">[W-A-S-D]</div> 
                        <div class="key-ex">YÖN TUŞLARI</div>
                    </div>
                    <div class="key-line">
                        <div class="key">[BOŞLUK]</div> 
                        <div class="key-ex">ZIPLA</div>
                    </div>
                `).fadeIn(400);
            });
        } else {
            $("#board-container").fadeOut(200, function() {
                $(this).html(`
                    <div class="key-line">
                        <div class="key">[G]</div> 
                        <div class="key-ex">KAYKAYA BİN</div>
                    </div>
                    <div class="key-line">
                        <div class="key">[E]</div> 
                        <div class="key-ex">KAYKAYI YERDEN AL</div>
                    </div>
                `).fadeIn(400);
            });
        }
    } else if (event.data.type === 'close') {
        $("#board-container").fadeOut(500)
    }
});