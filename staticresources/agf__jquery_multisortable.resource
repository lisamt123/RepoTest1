/**
 * jquery.multisortable.js - v0.2
 * https://github.com/shvetsgroup/jquery.multisortable
 *
 * Author: Ethan Atlakson, Jay Hayes, Gabriel Such, Alexander Shvets
 * Last Revision 3/16/2012
 * multi-selectable, multi-sortable jQuery plugin
 */

!function($) {

	$.fn.multisortable = function(options) {
		if (!options) {
			options = {}
		}
		var settings = $.extend({}, $.fn.multisortable.defaults, options);

		function regroup(item, list) {
			if (list.find('.selected').length > 0) {
				var myIndex = item.data('i');

				var itemsBefore = list.find('.selected').filter(function() {
					return $(this).data('i') < myIndex
				}).css({
						position: '',
						width: '',
						top: '',
						zIndex: ''
					});

				item.before(itemsBefore);

				var itemsAfter = list.find('.selected').filter(function() {
					return $(this).data('i') > myIndex
				}).css({
						position: '',
						width: '',
						top: '',
						zIndex: ''
					});

				item.after(itemsAfter);

				setTimeout(function() {
					itemsAfter.add(itemsBefore).addClass('selected');
				}, 0);
			}
		}

		return this.each(function() {
			var list = $(this);

			//enable sorting
			options.cancel = settings.items + ':not(.selected)';
			options.placeholder = settings.placeholder;
			options.start = function(event, ui) {
				if (ui.item.hasClass('selected')) {
					var parent = ui.item.parent();

					//assign indexes to all selected items
					parent.find('.selected').each(function(i) {
						$(this).data('i', i);
					});

					// adjust placeholder size to be size of items
					//var height = parent.find('.selected').length * ui.item.outerHeight();
					//ui.placeholder.height(height);
					//ui.placeholder.append('<div style="display:table-cell;"></div><div style="display:table-cell;"></div><div style="display:table-cell;"></div><div style="display:table-cell;"></div><div style="display:table-cell;"></div><div style="display:table-cell;"></div><div style="display:table-cell;"></div>');
					//console.log(ui.placeholder);
				}

				settings.start(event, ui);
			};

			options.stop = function(event, ui) {
				regroup(ui.item, ui.item.parent());
				settings.stop(event, ui);
			};

			options.sort = function(event, ui) {
				var parent = ui.item.parent(),
					myIndex = ui.item.data('i'),
					top = parseInt(ui.item.css('top').replace('px', '')),
					left = parseInt(ui.item.css('left').replace('px', ''));

				// fix to keep compatibility using prototype.js and jquery together
				$.fn.reverse = Array.prototype._reverse || Array.prototype.reverse

				// TC: Takes item and adds other items into it?
				var height = 0;
				$('.' + settings.selectedClass, parent).filter(function() {
					return $(this).data('i') < myIndex;
				}).reverse().each(function() {
						height += $(this).outerHeight();
						$(this).css({
							left: left,
							top: top - height,
							position: 'absolute',
							zIndex: 1000,
							width: ui.item.width()
						})
					});

				height = ui.item.outerHeight();
				$('.' + settings.selectedClass, parent).filter(function() {
					return $(this).data('i') > myIndex;
				}).each(function() {
						var item = $(this);
						item.css({
							left: left,
							top: top + height,
							position: 'absolute',
							zIndex: 1000,
							width: ui.item.width()
						});

						height += item.outerHeight();
					});
					
				settings.sort(event, ui);
			};

			options.receive = function(event, ui) {
				regroup(ui.item, ui.sender);
				settings.receive(event, ui);
			};

			list.sortable(options).disableSelection();
		})
	};

	$.fn.multisortable.defaults = {
		start: function(event, ui) {},
		stop: function(event, ui) {},
		sort: function(event, ui) {},
		receive: function(event, ui) {},
		click: function(event, elem) {},
		mousedown: function(event, elem) {},
		selectedClass: 'selected',
		placeholder: 'placeholder',
		items: 'li'
	};

}(jQuery);