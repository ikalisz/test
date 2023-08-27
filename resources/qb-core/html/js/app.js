
(() => {

    QBCore = {};
	QBCore.HUDElements = [];
    
    QBCore.ShowNotif = function (data) {
        var $notification = $('.notification.template').clone();
        $notification.removeClass('template');
        $notification.addClass(data.type);
        $notification.html(data.text);
        $notification.fadeIn();
        $('.notif-container').append($notification);
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);
    }

	QBCore.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	QBCore.insertHUDElement = function (name, index, priority, html, data) {
		QBCore.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		QBCore.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	QBCore.updateHUDElement = function (name, data) {
		for (let i = 0; i < QBCore.HUDElements.length; i++) {
			if (QBCore.HUDElements[i].name == name) {
				QBCore.HUDElements[i].data = data;
			}
		}

		QBCore.refreshHUD();
	};

	QBCore.deleteHUDElement = function (name) {
		for (let i = 0; i < QBCore.HUDElements.length; i++) {
			if (QBCore.HUDElements[i].name == name) {
				QBCore.HUDElements.splice(i, 1);
			}
		}

		QBCore.refreshHUD();
    };

    QBCore.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < QBCore.HUDElements.length; i++) {
			let html = Mustache.render(QBCore.HUDElements[i].html, QBCore.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

    window.addEventListener('message', function (event) {
        switch(event.data.action) {
            case 'insertHUDElement': 
                QBCore.insertHUDElement(event.data.name, event.data.index, event.data.priority, event.data.html, event.data.data);
                break;
            case 'updateHUDElement':
                QBCore.updateHUDElement(event.data.name, event.data.data);
                break;
            case 'deleteHUDElement':
                QBCore.deleteHUDElement(event.data.name);
                break;
            case 'show':
                QBCore.ShowNotif(event.data);
                break;
            default:
                QBCore.ShowNotif(event.data);
                break;
        }
    });
})();