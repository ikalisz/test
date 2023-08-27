$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'openPd') {
      $('#pd-card').css('display', 'flex');
      let photo = event.data.array.photo
      if (photo == "resimsiz") {
        $(".imgbox img").attr("src", "assets/images/pdresim.png");
      } else {
        $(".imgbox img").attr("src", event.data.array.photo);
      }
      $("#rankbox").html(event.data.array.rank)
      $("#namebox").html(event.data.array.name)
    } else if (event.data.action == 'open') {
      var type        = event.data.type;
      var userData    = event.data.array['user'];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;
      var userimage   = userData.photo;

      if ( type == 'driver' || type == null) {
        $('#name').css('color', '#282828');
        if ( sex == "Male" ) {
          if ( userimage == "resimsiz" ) {
            $("#new-user-photo img").attr("src", "assets/images/male.png");
          } else {
            $("#new-user-photo img").attr("src", userimage);
          }
          $('#sex').text('Male');
        } else {
          if ( userimage == "resimsiz" ) {
            $("#new-user-photo img").attr("src", "assets/images/female.png");
          } else {
            $("#new-user-photo img").attr("src", userimage);
          }
          $('#sex').text('Woman');
        }

        $('#name').text(userData.name);
        $('#dob').text(userData.dob);
        $('#lastdigits').text(userData.lastdigits);
        $('#signature').text(userData.name);

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key];
            if ( type == 'drive_bike') {
              $('#licenses').append('<p>Motorbike</p>');
            } else if ( type == 'drive_truck' ) {
              $('#licenses').append('<p>Truck</p>');
            } else if ( type == 'drive' ) {
              $('#licenses').append('<p>Car</p>');
            } else if ( type == 'aircraft' ) {
              $('#licenses').append('<p>Pilot</p>');
            }

          });
        }
          $('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
          $('#id-card').css('background', 'url(assets/images/idcard.png)');
        }
      } else if ( type == 'weapon' ) {
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.name);
        $('#dob').text(userData.dob);
        $('#signature').text(userData.name);
        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#pd-card').hide();
      $('#licenses').html('');
    }
  });
});
