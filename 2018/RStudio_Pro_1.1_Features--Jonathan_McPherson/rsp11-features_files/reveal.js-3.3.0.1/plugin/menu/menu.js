/*
 * Reveal.js menu plugin
 * MIT licensed
 * (c) Greg Denehy 2015
 */

var RevealMenu = window.RevealMenu || (function(){
	var config = Reveal.getConfig();
	var options = config.menu || {};
	options.path = options.path || scriptPath() || 'plugin/menu';

	var module = {};

	loadResource(options.path + '/lib/jeesh.min.js', 'script', function() {
	loadResource(options.path + '/lib/bowser.min.js', 'script', function() {
	loadResource(options.path + '/menu.css', 'stylesheet', function() {
		// does not support IE8 or below
		if (!bowser.msie || bowser.version >= 9) {
			//
			// Set option defaults
			//
			var side = options.side || 'left';	// 'left' or 'right'
			var numbers = options.numbers || false;
			var titleSelector = 'h1, h2, h3, h4, h5';
			if (typeof options.titleSelector === 'string') titleSelector = options.titleSelector;
			var hideMissingTitles = options.hideMissingTitles || false;
			var markers = options.markers || false;
			var custom = options.custom;
			var themes = options.themes;
			if (typeof themes === "undefined") {
				themes = [
					{ name: 'Black', theme: 'css/theme/black.css' },
					{ name: 'White', theme: 'css/theme/white.css' },
					{ name: 'League', theme: 'css/theme/league.css' },
					{ name: 'Sky', theme: 'css/theme/sky.css' },
					{ name: 'Beige', theme: 'css/theme/beige.css' },
					{ name: 'Simple', theme: 'css/theme/simple.css' },
					{ name: 'Serif', theme: 'css/theme/serif.css' },
					{ name: 'Blood', theme: 'css/theme/blood.css' },
					{ name: 'Night', theme: 'css/theme/night.css' },
					{ name: 'Moon', theme: 'css/theme/moon.css' },
					{ name: 'Solarized', theme: 'css/theme/solarized.css' }
				];
			}
			var transitions = options.transitions;
			if (typeof transitions === "undefined") transitions = true;
			if (bowser.msie && bowser.version <= 9) {
				// transitions aren't support in IE9 anyway, so no point in showing them
				transitions = false;
			}
			var openButton = options.openButton;
			if (typeof openButton === "undefined") openButton = true;
			var openSlideNumber = options.openSlideNumber;
			if (typeof openSlideNumber === "undefined") openSlideNumber = false;
			var keyboard = options.keyboard;
			if (typeof keyboard === "undefined") keyboard = true;

			function disableMouseSelection() {
				mouseSelectionEnabled = false;
			}

			function reenableMouseSelection() {
				// wait until the mouse has moved before re-enabling mouse selection
				// to avoid selections on scroll
				$('nav.slide-menu').one('mousemove', function(event) {
					//XXX this should select the item under the mouse
					mouseSelectionEnabled = true;
				});
			}

			//
			// Keyboard handling
			//
			function getOffset(el) {
				var _x = 0;
				var _y = 0;
				while(el && !isNaN(el.offsetLeft) && !isNaN(el.offsetTop)) {
					_x += el.offsetLeft - el.scrollLeft;
					_y += el.offsetTop - el.scrollTop;
					el = el.offsetParent;
				}
				return { top: _y, left: _x };
			}

			function visibleOffset(el) {
				var offsetFromTop = getOffset(el).top - el.offsetParent.offsetTop;
				if (offsetFromTop < 0) return -offsetFromTop
				var offsetFromBottom = el.offsetParent.offsetHeight - (el.offsetTop - el.offsetParent.scrollTop + el.offsetHeight);
				if (offsetFromBottom < 0) return offsetFromBottom; 
				return 0;
			}

			function keepVisible(el) {
				var offset = visibleOffset(el);
				if (offset) {
					disableMouseSelection();
					el.scrollIntoView(offset > 0);
					reenableMouseSelection();	
				}
			}

			function scrollItemToTop(el) {
				disableMouseSelection();
				el.offsetParent.scrollTop = el.offsetTop;
				reenableMouseSelection();	
			}

			function scrollItemToBottom(el) {
				disableMouseSelection();
				el.offsetParent.scrollTop = el.offsetTop - el.offsetParent.offsetHeight + el.offsetHeight
				reenableMouseSelection();	
			}

			function selectItem(el) {
				$(el).addClass('selected');
				keepVisible(el);
			}

			function onDocumentKeyDown(event) {
				if (event.keyCode === 77) {
					toggleMenu();
				} else if (isOpen()) {
					event.stopImmediatePropagation();
					switch( event.keyCode ) {
						// h, left - change panel
						case 72: case 37:
							prevPanel();
							break;
						// l, right - change panel
						case 76: case 39:
							nextPanel();
							break;
						// k, up
						case 75: case 38:
							var currItem = $('.active-menu-panel .slide-menu-items li.selected').get(0) || $('.active-menu-panel .slide-menu-items li.active').get(0);
							if (currItem) {
								$('.active-menu-panel .slide-menu-items li').removeClass('selected');
								var nextItem = $('.active-menu-panel .slide-menu-items li[data-item="' + ($(currItem).data('item') - 1) + '"]').get(0) || currItem;
								selectItem(nextItem);
							} else {
								var items = $('.active-menu-panel .slide-menu-items li.slide-menu-item');
								if (items.length > 0) {
									selectItem(items.get(0));
								}
							}
							break;
						// j, down
						case 74: case 40:
							var currItem = $('.active-menu-panel .slide-menu-items li.selected').get(0) || $('.active-menu-panel .slide-menu-items li.active').get(0);
							if (currItem) {
								$('.active-menu-panel .slide-menu-items li').removeClass('selected');
								var nextItem = $('.active-menu-panel .slide-menu-items li[data-item="' + ($(currItem).data('item') + 1) + '"]').get(0) || currItem;
								selectItem(nextItem);
							} else {
								var items = $('.active-menu-panel .slide-menu-items li.slide-menu-item');
								if (items.length > 0) {
									selectItem(items.get(0));
								}
							}
							break;
						// pageup, u
						case 33: case 85:
							var itemsAbove = $('.active-menu-panel .slide-menu-items li').filter(function(item) { return visibleOffset(item) > 0; });
							var visibleItems = $('.active-menu-panel .slide-menu-items li').filter(function(item) { return visibleOffset(item) == 0; });

							var firstVisible = (itemsAbove.length > 0 && Math.abs(visibleOffset(itemsAbove[itemsAbove.length-1])) < itemsAbove[itemsAbove.length-1].clientHeight ? itemsAbove[itemsAbove.length-1] : visibleItems[0]);
							if (firstVisible) {
								if ($(firstVisible).hasClass('selected') && itemsAbove.length > 0) {
									// at top of viewport already, page scroll (if not at start)
									// ...move selected item to bottom, and change selection to last fully visible item at top
									scrollItemToBottom(firstVisible);
									visibleItems = $('.active-menu-panel .slide-menu-items li').filter(function(item) { return visibleOffset(item) == 0; });
									if (visibleItems[0] == firstVisible) {
										// prev item is still beyond the viewport (for custom panels)
										firstVisible = itemsAbove[itemsAbove.length-1];
									} else {
										firstVisible = visibleItems[0];
									}
								}
								$('.active-menu-panel .slide-menu-items li').removeClass('selected');
								selectItem(firstVisible);
								// ensure selected item is positioned at the top of the viewport
								scrollItemToTop(firstVisible);
							}
							break;
						// pagedown, d
						case 34: case 68:
							var visibleItems = $('.active-menu-panel .slide-menu-items li').filter(function(item) { return visibleOffset(item) == 0; });
							var itemsBelow = $('.active-menu-panel .slide-menu-items li').filter(function(item) { return visibleOffset(item) < 0; });

							var lastVisible = (itemsBelow.length > 0 && Math.abs(visibleOffset(itemsBelow[0])) < itemsBelow[0].clientHeight ? itemsBelow[0] : visibleItems[visibleItems.length-1]);
							if (lastVisible) {
								if ($(lastVisible).hasClass('selected') && itemsBelow.length > 0) {
									// at bottom of viewport already, page scroll (if not at end)
									// ...move selected item to top, and change selection to last fully visible item at bottom
									scrollItemToTop(lastVisible);
									visibleItems = $('.active-menu-panel .slide-menu-items li').filter(function(item) { return visibleOffset(item) == 0; });
									if (visibleItems[visibleItems.length-1] == lastVisible) {
										// next item is still beyond the viewport (for custom panels)
										lastVisible = itemsBelow[0];
									} else {
										lastVisible = visibleItems[visibleItems.length-1];
									}
								}
								$('.active-menu-panel .slide-menu-items li').removeClass('selected');
								selectItem(lastVisible);
								// ensure selected item is positioned at the bottom of the viewport
								scrollItemToBottom(lastVisible);
							}
							break;
						// home
						case 36:
							$('.active-menu-panel .slide-menu-items li').removeClass('selected');
							var sel = $('.active-menu-panel .slide-menu-items li:first-of-type');
							if (sel.length > 0) {
								keepVisible(sel.addClass('selected').get(0));
							}
							break;
						// end
						case 35:
							$('.active-menu-panel .slide-menu-items li').removeClass('selected');
							var sel = $('.active-menu-panel .slide-menu-items li:last-of-type');
							if (sel.length > 0) {
								keepVisible(sel.addClass('selected').get(0));
							}
							break;
						// space, return
						case 32: case 13:
							var currItem = $('.active-menu-panel .slide-menu-items li.selected').get(0);
							if (currItem) {
								openItem(currItem);
							}
							break;
						// esc
						case 27: closeMenu(); break;
					}
				}
			}

			if (keyboard) {
				//XXX add keyboard option for custom key codes, etc.

				document.addEventListener('keydown', onDocumentKeyDown, false);

				// handle key presses within speaker notes
				window.addEventListener( 'message', function( event ) {
					var data = JSON.parse( event.data );
					if (data.method === 'triggerKey') {
						onDocumentKeyDown( { keyCode: data.args[0], stopImmediatePropagation: function() {} } );
					}
				});

				// Prevent reveal from processing keyboard events when the menu is open
				if (config.keyboardCondition && typeof config.keyboardCondition === 'function') {
					// combine user defined keyboard condition with the menu's own condition
					var userCondition = config.keyboardCondition;
					config.keyboardCondition = function() {
						return userCondition() && !isOpen();
					};
				} else {
					config.keyboardCondition = function() { return !isOpen(); }
				}
			}


			//
			// Utilty functions
			//

			function openMenu(event) {
				if (event) event.preventDefault();
				if (!isOpen()) {
				    $('body').addClass('slide-menu-active');
				    $('.reveal').addClass('has-' + options.effect + '-' + side);
				    $('.slide-menu').addClass('active');
				    $('.slide-menu-overlay').addClass('active');

				    // identify active theme
				    $('div[data-panel="Themes"] li').removeClass('active');
				    $('li[data-theme="' + $('#theme').attr('href') + '"]').addClass('active');

				    // identify active transition
				    $('div[data-panel="Transitions"] li').removeClass('active');
				    $('li[data-transition="' + Reveal.getConfig().transition + '"]').addClass('active');

				    // set item selections to match active items
				    $('.slide-menu-panel li.active')
				    	.addClass('selected')
				    	.each(function(item) { keepVisible(item) });
				}
			}

			function closeMenu(event) {
				if (event) event.preventDefault();
			    $('body').removeClass('slide-menu-active');
			    $('.reveal').removeClass('has-' + options.effect + '-' + side);
			    $('.slide-menu').removeClass('active');
			    $('.slide-menu-overlay').removeClass('active');
			    $('.slide-menu-panel li.selected').removeClass('selected');
			}

			function toggleMenu(event) {
				if (isOpen()) {
					closeMenu(event);
				} else {
					openMenu(event);
				}
			}

			function isOpen() {
				return $('body').hasClass('slide-menu-active');
			}

			function openPanel(e) {
				openMenu();
				var panel = e;
				if (typeof e !== "string") {
					panel = $(e.currentTarget).data('panel');
				}
				$('.slide-menu-toolbar > li').removeClass('active-toolbar-button');
				$('li[data-panel="' + panel + '"]').addClass('active-toolbar-button');
				$('.slide-menu-panel').removeClass('active-menu-panel');
				$('div[data-panel="' + panel + '"]').addClass('active-menu-panel');
			}

			function nextPanel() {
				var next = ($('.active-toolbar-button').data('button') + 1) % buttons;
				openPanel($('.toolbar-panel-button[data-button="' + next + '"]').data('panel'));
			}

			function prevPanel() {
				var next = $('.active-toolbar-button').data('button') - 1;
				if (next < 0) {
					next = buttons - 1;
				}
				openPanel($('.toolbar-panel-button[data-button="' + next + '"]').data('panel'));
			}

			$('<nav class="slide-menu slide-menu--' + side + '"></nav>')
				.appendTo($('.reveal'));
			$('<div class="slide-menu-overlay"></div>')
				.appendTo($('.reveal'))
				.click(closeMenu);

			var toolbar = $('<ol class="slide-menu-toolbar"></ol>').prependTo($('.slide-menu'));
			var buttons = 0;
			$('<li data-panel="Slides" data-button="' + (buttons++) + '" class="toolbar-panel-button"><span class="slide-menu-toolbar-label">Slides</span><br/><i class="fa fa-list"></i></li>')
				.appendTo(toolbar)
				.addClass('active-toolbar-button')
				.click(openPanel);

			if (custom) {
				custom.forEach(function(element, index, array) {
					$('<li data-panel="Custom' + index + '" data-button="' + (buttons++) + '" class="toolbar-panel-button"><span class="slide-menu-toolbar-label">' + element.title + '</span><br/>' + element.icon + '</i></li>')
						.appendTo(toolbar)
						.click(openPanel);
				})
			}

			if (themes) {
				$('<li data-panel="Themes" data-button="' + (buttons++) + '" class="toolbar-panel-button"><span class="slide-menu-toolbar-label">Themes</span><br/><i class="fa fa-desktop"></i></li>')
					.appendTo(toolbar)
					.click(openPanel);
			}
			if (transitions) {
				$('<li data-panel="Transitions" data-button="' + (buttons++) + '" class="toolbar-panel-button"><span class="slide-menu-toolbar-label">Transitions</span><br/><i class="fa fa-arrows-h"></i></li>')
					.appendTo(toolbar)
					.click(openPanel);
			}
			$('<li id="close"><span class="slide-menu-toolbar-label">Close</span><br/><i class="fa fa-times"></i></li>')
				.appendTo(toolbar)
				.click(closeMenu);

			var panels = $('.slide-menu');

			//
			// Slide links
			//
			function generateItem(type, section, i, h, v) {
				var link = '/#/' + h;
				if (typeof v === 'number' && !isNaN( v )) link += '/' + v;

				var title = $(section).data('menu-title') ||
					$('.menu-title', section).text() ||
					$(titleSelector, section).text();
				if (!title) {
					if (hideMissingTitles) return '';
					title = "Slide " + i;
					type += ' no-title';
				}

				title = '<span class="slide-menu-item-title">' + title + '</span>';
				if (numbers) {
					// Number formatting taken from reveal.js
					var value = [];
					var format = 'h.v';

					// Check if a custom number format is available
					if( typeof numbers === 'string' ) {
						format = numbers;
					}
					else if (typeof config.slideNumber === 'string') {
						// Take user defined number format for slides
						format = config.slideNumber;
					}

					switch( format ) {
						case 'c':
							value.push( i );
							break;
						case 'c/t':
							value.push( i, '/', Reveal.getTotalSlides() );
							break;
						case 'h/v':
							value.push( h + 1 );
							if( typeof v === 'number' && !isNaN( v ) ) value.push( '/', v + 1 );
							break;
						default:
							value.push( h + 1 );
							if( typeof v === 'number' && !isNaN( v ) ) value.push( '.', v + 1 );
					}

					title = '<span class="slide-menu-item-number">' + value.join('') + '. </span>' + title;
				}

				var m = '';
				if (markers) {
					m = '<i class="fa fa-check-circle past"></i>' +
								'<i class="fa fa-dot-circle-o active"></i>' + 
								'<i class="fa fa-circle-thin future"></i>';
				}

				return '<li class="' + type + '" data-item="' + i + '" data-slide-h="' + h + '" data-slide-v="' + (v === undefined ? 0 : v) + '">' + m + title + '</li>';
			}

			function openItem(item) {
				var h = $(item).data('slide-h');
				var v = $(item).data('slide-v');
				var theme = $(item).data('theme');
				var transition = $(item).data('transition');
				if (typeof h !== "undefined" && typeof v !== "undefined") {
					Reveal.slide(h, v);
					closeMenu();
				} else if (theme) {
					$('#theme').attr('href', theme);
					closeMenu();
				} else if (transition) {
					Reveal.configure({ transition: transition });
					closeMenu();
				} else {
					var links = $(item).find('a');
					if (links.length > 0) {
						links.get(0).click();
					}
					closeMenu();
				}
			}

			function clicked(event) {
				if (event.target.nodeName !== "A") {
					event.preventDefault();
				}
				openItem(event.currentTarget);
			}

			function highlightCurrentSlide() {
				var state = Reveal.getState();
				$('li.slide-menu-item, li.slide-menu-item-vertical')
					.removeClass('past')
					.removeClass('active')
					.removeClass('future');

				$('li.slide-menu-item, li.slide-menu-item-vertical').each(function(e) {
					var h = $(e).data('slide-h');
					var v = $(e).data('slide-v');
					if (h < state.indexh || (h === state.indexh && v < state.indexv)) {
						$(e).addClass('past');
					}
					else if (h === state.indexh && v === state.indexv) {
						$(e).addClass('active');
					}
					else {
						$(e).addClass('future');
					}
				});
			}

			function createSlideMenu() {
				if ( !document.querySelector('section[data-markdown]:not([data-markdown-parsed])') ) {
					$('<div data-panel="Slides" class="slide-menu-panel"><ul class="slide-menu-items"></ul></div>')
						.appendTo(panels)
						.addClass('active-menu-panel');
					var items = $('.slide-menu-panel[data-panel="Slides"] > .slide-menu-items');
					var slideCount = 0;
					$('.slides > section').each(function(section, h) {
						var subsections = $('section', section);
						if (subsections.length > 0) {
							subsections.each(function(subsection, v) {
								var type = (v === 0 ? 'slide-menu-item' : 'slide-menu-item-vertical');
								var item = generateItem(type, subsection, slideCount, h, v);
								if (item) {
									slideCount++;
									items.append(item);
								}
							});
						} else {
							var item = generateItem('slide-menu-item', section, slideCount, h);
							if (item) {
								slideCount++;
								items.append(item);
							}
						}
					});
					$('.slide-menu-item, .slide-menu-item-vertical').click(clicked);
					highlightCurrentSlide();
				}
				else {
				// wait for markdown to be loaded and parsed
					setTimeout( createSlideMenu, 100 );
				}
			}

			createSlideMenu();
			Reveal.addEventListener('slidechanged', highlightCurrentSlide);

			//
			// Custom menu panels
			//
			if (custom) {
				function xhrSuccess () {
					if (this.status >= 200 && this.status < 300) {
						$(this.responseText).appendTo(this.panel);
						enableCustomLinks(this.panel);
					}
					else {
						showErrorMsg(this)
					}
				}
				function xhrError () {
					showErrorMsg(this)
				}
				function loadCustomPanelContent (panel, sURL) {
					var oReq = new XMLHttpRequest();
					oReq.panel = panel;
					oReq.arguments = Array.prototype.slice.call(arguments, 2);
					oReq.onload = xhrSuccess;
					oReq.onerror = xhrError;
					oReq.open("get", sURL, true);
					oReq.send(null);
				}
				function enableCustomLinks(panel) {
					$(panel).find('ul.slide-menu-items li.slide-menu-item').each(function(item, i) {
						$(item).attr('data-item', i+1);
						$(item).click(clicked);
					});
				}
				function showErrorMsg(response) {
					var msg = '<p>ERROR: The attempt to fetch ' + response.responseURL + ' failed with HTTP status ' + 
						response.status + ' (' + response.statusText + ').</p>' +
						'<p>Remember that you need to serve the presentation HTML from a HTTP server.</p>';
						$(msg).appendTo(response.panel)
				}

				custom.forEach(function(element, index, array) {
					var panel = $('<div data-panel="Custom' + index + '" class="slide-menu-panel slide-menu-custom-panel"></div>');
					if (element.content) {
						$(element.content).appendTo(panel);
						enableCustomLinks(panel);
					}
					else if (element.src) {
						loadCustomPanelContent(panel, element.src);
					}
					panel.appendTo(panels);
				})
			}

			//
			// Themes
			//
			if (themes) {
				var panel = $('<div data-panel="Themes" class="slide-menu-panel"></div>').appendTo(panels);
				var menu = $('<ul class="slide-menu-items"></ul>').appendTo(panel);
				themes.forEach(function(t, i) {
					$('<li class="slide-menu-item" data-theme="' + t.theme + '" data-item="' + (i+1) + '">' + t.name + '</li>').appendTo(menu).click(clicked);
				})
			}

			//
			// Transitions
			//
			if (transitions) {
				var panel = $('<div data-panel="Transitions" class="slide-menu-panel"></div>').appendTo(panels);
				var menu = $('<ul class="slide-menu-items"></ul>').appendTo(panel);
				  ['None', 'Fade', 'Slide', 'Convex', 'Concave', 'Zoom', 'Cube', 'Page'].forEach(function(name, i) {
					$('<li class="slide-menu-item" data-transition="' + name.toLowerCase() + '" data-item="' + (i+1) + '">' + name + '</li>').appendTo(menu).click(clicked);
				})
			}

			//
			// Open menu options
			//
			if (openButton) {
				// add menu button
				$('<div class="slide-menu-button"><a href="#"><i class="fa fa-bars"></i></a></div>')
					.appendTo($('.reveal'))
					.click(openMenu);
			}

			if (openSlideNumber) {
				// wrap slide number in link
				$('<div class="slide-number-wrapper"><a href="#"></a></div>').insertAfter($('div.slide-number'));
				$('.slide-number').appendTo($('.slide-number-wrapper a'));
				$('.slide-number-wrapper a').click(openMenu);
			}

			//
			// Handle mouse overs
			//
			var mouseSelectionEnabled = true;
			$('.slide-menu-panel .slide-menu-items li').mouseenter(function(event) {
				if (mouseSelectionEnabled) {
					$('.active-menu-panel .slide-menu-items li').removeClass('selected');
					$(event.currentTarget).addClass('selected');
				}
			});

			module.toggle = toggleMenu;
			module.isOpen = isOpen;

			/**
			 * Extend object a with the properties of object b.
			 * If there's a conflict, object b takes precedence.
			 */
			function extend( a, b ) {
				for( var i in b ) {
					a[ i ] = b[ i ];
				}
			}

			/**
			 * Dispatches an event of the specified type from the
			 * reveal DOM element.
			 */
			function dispatchEvent( type, args ) {
				var event = document.createEvent( 'HTMLEvents', 1, 2 );
				event.initEvent( type, true, true );
				extend( event, args );
				document.querySelector('.reveal').dispatchEvent( event );

				// If we're in an iframe, post each reveal.js event to the
				// parent window. Used by the notes plugin
				if( config.postMessageEvents && window.parent !== window.self ) {
					window.parent.postMessage( JSON.stringify({ namespace: 'reveal', eventName: type, state: getState() }), '*' );
				}
			}

			dispatchEvent('menu-ready');
		}
	})
	})
	});

	// modified from math plugin
	function loadResource( url, type, callback ) {
		var head = document.querySelector( 'head' );
		var resource;

		if ( type === 'script' ) {
			resource = document.createElement( 'script' );
			resource.type = 'text/javascript';
			resource.src = url;
		}
		else if ( type === 'stylesheet' ) {
			resource = document.createElement( 'link' );
			resource.rel = 'stylesheet';
			resource.href = url;
		}

		// Wrapper for callback to make sure it only fires once
		var finish = function() {
			if( typeof callback === 'function' ) {
				callback.call();
				callback = null;
			}
		}

		resource.onload = finish;

		// IE
		resource.onreadystatechange = function() {
			if ( this.readyState === 'loaded' ) {
				finish();
			}
		}

		// Normal browsers
		head.appendChild( resource );
	}

	function scriptPath() {
		// obtain plugin path from the script element
		var path;
		if (document.currentScript) {
			path = document.currentScript.src.slice(0, -7);
		} else {
			var sel = document.querySelector('script[src$="/menu.js"]')
			if (sel) {
				path = sel.src.slice(0, -7);
			}
		}
		return path;
	}

	return module;
})();
