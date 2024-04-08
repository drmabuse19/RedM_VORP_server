const { createApp } = Vue
  createApp({
    data() {
      return {
        visible: false,
        opress: false,
        config: {}
      }
    },
    mounted() {
        window.addEventListener('message', this.onMessage);
    },
    destroyed() {
        window.removeEventListener('message')
    },
    methods: {
        onMessage(event) {
            if (event.data.type === 'toggle') {
              this.visible = event.data.visible
            }

            if (event.data.config) {
              this.config = event.data.config
            }

            if (event.data.type === 'escapekeypress') {
              this.opress = event.data.state
            }
        }
    }
  }).mount('#app')