const { useQuasar } = Quasar;
const { onMounted, onUnmounted } = Vue;
const app = Vue.createApp({
  data() {
    return {
      NotificationConfig: {
        group: true,
        position: 'top-right',
        progress: true
      },
    };
  },
  setup() {
    const $q = useQuasar();
    const showNotif = (e) => {
      const text = e.data.text;
      const length = e.data.length;
      const type = e.data.type;
      const caption = e.data.caption;

      switch (type) {
        case 'success':
          classes = 'success';
          bosluk = '5'
          break;
        case 'primary':
          classes = 'primary';
          bosluk = '10';
          break;
        case 'error':
          classes = 'error';
          bosluk = '15';
          break;
      }



      if (text.length > 300) {
        multiline = true;
      } else {
        multiline = false;
      }

      $q.notify({
        message: text,
        caption: caption,
        multiLine: multiline,
        group: NotificationConfig.spamnotify,
        progress: NotificationConfig.progress,
        position: NotificationConfig.position,
        timeout: length,
        icon: bosluk,
        classes: classes,
      });
    };
    onMounted(() => {
      fetch(`https://${GetParentResourceName()}/getNotifyConfig`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
      }).then(resp => resp.json()).then(resp => {
        NotificationConfig = JSON.parse(resp)
      });

      window.addEventListener('message', showNotif);
    });
    onUnmounted(() => {
      window.removeEventListener('message', showNotif);
    });
    return {};
  },
});
app.use(Quasar, { config: {} });
app.mount('#notify');