// 2 kere para gönderme ve bildirim görünme fix 

(() => {
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    showUi();
                    break;
            }
        });

        var userWin = false;
		var stopUi = false;

        var arrayShuffle = function(array) {
           for ( var i = 0, length = array.length, swap = 0, temp = ''; i < length; i++ ) {
              swap        = Math.floor(Math.random() * (i + 1));
              temp        = array[swap];
              array[swap] = array[i];
              array[i]    = temp;
           }
           return array;
        };

        var percentageChance = function(values, chances) {
           for ( var i = 0, pool = []; i < chances.length; i++ ) {
              for ( var i2 = 0; i2 < chances[i]; i2++ ) {
                 pool.push(i);
              }
           }
           return values[arrayShuffle(pool)['0']];
        };

        var win =  percentageChance(['5', '25', '75', '250', '1000', '2000', '3000', '5000'], [99, 97, 95, 80, 45, 35, 99, 99]);
        var win1 = percentageChance(['5', '25', '75', '250', '1000', '2000', '3000', '5000'], [99, 97, 95, 80, 45, 35, 99, 99]);
        var win2 = percentageChance(['5', '25', '75', '250', '1000', '2000', '3000', '5000'], [99, 97, 95, 80, 45, 35, 1, 1]);
        var win3 = percentageChance(['5', '25', '75', '250', '1000', '2000', '3000', '5000'], [99, 97, 95, 80, 45, 35, 1, 1]);
        var win4 = percentageChance(['5', '25', '75', '250', '1000', '2000', '3000', '5000'], [99, 97, 95, 80, 45, 35, 1, 1]);
        var win5 = percentageChance(['5', '25', '75', '250', '1000', '2000', '3000', '5000'], [99, 97, 95, 80, 45, 35, 1, 1]);

        var y = [
          win,
          win1,
          win2,
          win3,
          win4,
          win5
        ];

        function compressArray(original) {
 
            var compressed = [];
            // make a copy of the input array
            var copy = original.slice(0);
         
            // first loop goes over every element
            for (var i = 0; i < original.length; i++) {
         
                var myCount = 0;    
                // loop over every element in the copy and see if it's the same
                for (var w = 0; w < copy.length; w++) {
                    if (original[i] == copy[w]) {
                        // increase amount of times duplicate is found
                        myCount++;
                        // sets item to undefined
                        delete copy[w];
                    }
                }
         
                if (myCount > 0) {
                    var a = new Object();
                    a.value = original[i];
                    a.count = myCount;
                    compressed.push(a);
                }
            }
         
            return compressed;
        };

        var newArray = compressArray(y);

        for (var i = 0; i < newArray.length; i++) {
            if(newArray[i].count > 2) {
				stopUi = false;
                userWin = true;
                userPrice = newArray[i].value;
            }
        }

        for ( var i = 0; i < 1; i++ ) {
            $('#prizeTable').append(`
                <tr>
                    <td height="20">$${win}</td>
                    <td height="20">$${win1}</td>
                </tr>
                <tr>
                    <td height="20">$${win2}</td>
                    <td height="20">$${win3}</td>
                </tr>
                <tr>
                    <td height="20">$${win4}</td>
                    <td height="20">$${win5}</td>
                </tr>
            `)
        }

        $('#scratch').wScratchPad({
          size        : 40,          // The size of the brush/scratch.
          bg          : 'img/1.png',  // Background (image path or hex color).
          fg          : '#000',  // Foreground (image path or hex color).
          realtime    : true,       // Calculates percentage in realitime.
          scratchDown : null,       // Set scratchDown callback.
          scratchUp   : null,       // Set scratchUp callback.
          scratchMove: function(e, percent){ 
            if(percent > 65) {
                $('#scratch').wScratchPad('clear');
                setTimeout(function(){ 
					if(stopUi == false){
						stopUi = true;
						if (userWin) {
                        $.post('https://kazikazan/reward', JSON.stringify({price: userPrice}));
                        location.reload(true);
						} else {
							$.post('https://kazikazan/reward', JSON.stringify({}));
							location.reload(true);
						}
					}                    
                    $('#scratch').wScratchPad('reset');
                }, 3000);
            }
          }
        });
    }

    function showUi() {
        $('body').removeClass('hidden');
    }

    function closeUi() {
        $('body').addClass('hidden');
    }
	
	

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('https://kazikazan/escape', JSON.stringify({}));
            location.reload(true);
            $('body').addClass('hidden');
        }
    }
    
})();