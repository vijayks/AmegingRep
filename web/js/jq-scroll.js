(function($) {
    $.fn.extend({
        scrollList : function(direction, pixels_per_second, delay, showCount, mouseOverScroll) {
            if ('undefined' == typeof(pixels_per_second)) {
                pixels_per_second = 20;
            }

            if ('undefined' == typeof(delay)) {
                delay = 1000;
            }

            if ('undefined' == typeof(direction) || -1 == $.inArray(direction, ['up', 'down', 'left', 'right'])) {
                direction = 'up';
            }

            if ('undefined' == typeof(showCount)) {
                showCount = 3;
            }

            if ('undefined' == typeof(mouseOverScroll)) {
                mouseOverScroll = true;
            }

            var $list = $(this);
            var $current_li;
            var pixels_per_millisecond = pixels_per_second / 1000;
            var easing = (delay == 0) ? 'linear' : 'swing';
            var div = document.getElementById($list.attr("id"));
            div.mouseIsOver = false;

            //Set the height of scroller
            var len=($('#'+$list.attr('id')+' li').length);
            if(showCount>len)
                $list.css('height',len*pixels_per_second);
            else
                $list.css('height',showCount*pixels_per_second);

            if(len==1){
                $('#'+$list.attr('id')+' ul').append('<li>'+$('#'+$list.attr('id')+' li:first').html()+'</li>');
            }

            // Set position relative if position is currently static so top/left properties will affect it's position
            if ('static' == $list.css('position')) {
                $list.css('position', 'relative');
            }

            /*
             * Remove text nodes between lis since they add spacing that
             * will be removed when shifting lis from end to end
             */
            if ('left' == direction || 'right' == direction) {
                var text = [];
            	this.each(function() {
            		var children = this.childNodes;
            		for (var i = 0; i < children.length; i++) {
            			var child = children[i];
            			if (child.nodeType == 3) {
            			    text.push(child);
            			}
            		}
            	});

            	$(this.pushStack(text)).remove();
            }

            if ('up' == direction || 'left' == direction) {
                $current_li = $('#'+$list.attr("id")+' li:first');
            }
            else {

                /*
                 * If right or down, move the last li to the beginning and move the entire
                 * list up/left to allow the next li to scroll into view rather than just appear.
                 */
                var $last_li = $('#'+$list.attr("id")+' li:last');
                if ('down' == direction) {
                    $list.css('top', '-' + $last_li.outerHeight() + 'px');
                }
                else {
                    $list.css('left', '-' + $last_li.outerWidth() + 'px');
                }
                $last_li.remove();
                $('#'+$list.attr("id")+' li:first').before($last_li);
                $current_li = $('#'+$list.attr("id")+' li:last');
            }


            function scrollListNext() {
                if(!mouseOverScroll){
                    div = document.getElementById($list.attr("id"));
                    div.onmouseover = function()   {
                      this.mouseIsOver = true;
                   };
                   div.onmouseout = function()   {
                      this.mouseIsOver = false;
                   }
                }
                var distance, property;
                var css = {};

                if ('up' == direction || 'down' == direction) {
                    property = 'top';
                    distance = $current_li.outerHeight();
                }
                else {
                    property = 'left';
                    distance = $current_li.outerWidth();
                }

                switch (direction) {
                    case 'up':
                        css.top = '-' + distance + 'px';
                        break;

                    case 'right':
                        css.left = 0;
                        break;

                    case 'down':
                        css.top = 0;
                        break;

                    case 'left':
                        css.left = '-' + distance + 'px';
                        break;
                };

                var duration = distance / pixels_per_millisecond;
                
                var $last_current_li=$current_li;
                 if(!this.mouseIsOver)
                $current_li.animate({opacity: 0.0}, 500);
                $list.animate(css, duration, easing, function() {
                 if(!this.mouseIsOver){
                    $current_li.remove();
                    if ('up' == direction || 'left' == direction) {
                        $list.css(property, 0);
                        $('#'+$list.attr("id")+' li:last').after($current_li);
                        $current_li = $('#'+$list.attr("id")+' li:first');
                    }
                    else {
                        $list.css(property, '-' + distance + 'px');
                        $('#'+$list.attr("id")+' li:first').before($current_li);
                        $current_li = $('#'+$list.attr("id")+' li:last');
                    }
                $last_current_li.animate({opacity: 1.0}, 100);
                    }
                    setTimeout(scrollListNext, delay);
                });
            };

            setTimeout(scrollListNext, delay);
        }
    });
})(jQuery);
