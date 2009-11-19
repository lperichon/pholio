$(document).ready(function() { //perform actions when DOM is ready
  var z = 0; //for setting the initial z-index's
  var inAnimation = false; //flag for testing if we are in a animation
  var imgLoaded = 0; //for checking if all images are loaded
  var max_width = 0; // horrible hack because Im tired of dealing with ul widths
  var max_height = 0;
  $('#pictures').append('<div id="loader"></div>'); //append the loader div, it overlaps all pictures

  $('#pictures li img').each(function() { //set the initial z-index's
    z++; //at the end we have the highest z-index value stored in the z variable
    $(this).css('z-index', z); //apply increased z-index to <img>
    var width = $(this).width();
    var height = $(this).height();
    if(width > max_width) {
      max_width = width;
    }
    if(height > max_height) {
      max_height = height;
    }
    $(new Image()).attr('src', $(this).attr('src')).load(function() { //create new image object and have a callback when it's loaded
      imgLoaded++; //one more image is loaded

      if(imgLoaded == z) { //do we have all pictures loaded?
        $('#loader').fadeOut('slow'); //if so fade out the loader div
      }
    });
  });

  $('#pictures ul').css('width',max_width);
  $('#pictures ul').css('height',max_height + 5);

  function swapFirstLast(isFirst) {
    if(inAnimation) return false; //if already swapping pictures just return
    else inAnimation = true; //set the flag that we process a image
    
    var processZindex, direction, newZindex, inDeCrease; //change for previous or next image
    
    if(isFirst) { processZindex = z; direction = '-'; newZindex = 1; inDeCrease = 1; } //set variables for "next" action
    else { processZindex = 1; direction = ''; newZindex = z; inDeCrease = -1; } //set variables for "previous" action
    
    $('#pictures li img').each(function() { //process each image
      if($(this).css('z-index') == processZindex) { //if its the image we need to process
        $(this).animate({ 'top' : direction + $(this).height() + 'px' }, 'slow', function() { //animate the img above/under the gallery (assuming all pictures are equal height)
          $(this).css('z-index', newZindex) //set new z-index
            .animate({ 'top' : '0' }, 'slow', function() { //animate the image back to its original position
              inAnimation = false; //reset the flag
            });
        });
      } else { //not the image we need to process, only in/de-crease z-index
        $(this).animate({ 'top' : '0' }, 'slow', function() { //make sure to wait swapping the z-index when image is above/under the gallery
          $(this).css('z-index', parseInt($(this).css('z-index')) + inDeCrease); //in/de-crease the z-index by one
        });
      }
    });
    
    return false; //don't follow the clicked link
  }

  $('#next a').click(function() {
    return swapFirstLast(true); //swap first image to last position
  });
  
  $('#prev a').click(function() {
    return swapFirstLast(false); //swap last image to first position
  });
});