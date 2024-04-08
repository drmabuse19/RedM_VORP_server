const { createApp } = Vue;

var tag = document.createElement("script");
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName("script")[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

let vueApp = createApp({
  data() {
    return { //returns the data/sets it
      source: '',
      vidid: '',
      volume: 0,
      loop: 0,
      play: false
    }
  },
  mounted() { //this will run once the app.js is mounted fully ready too go
    window.addEventListener('message', this.onMessage); //creates an event lister so it will listen too any nui events that run
  },
  destroyed() {
    window.removeEventListener("message");
  },
  methods: {
    onMessage(event) { //creates an event named on message
      if (event.data.type === 'open') { //if the data passed too it is the string open then
        this.source = event.data.embedlink
        this.vidid = event.data.videoid
        this.loop = event.data.loop
        this.volume = event.data.volume
        this.play = true
        vueApp.initYoutube()
      }
      if (event.data.type === 'close') {
        this.play = false
        vueApp.initYoutube()
      }
    },
    initYoutube() {
      const that = this;
      if (this.play === true) { 
        this.player = new YT.Player("ytplayer", {
          width: 0,
          height: 0,
          videoId: this.vidid,
          playerVars: {
            'playsinline': 1,
            'controls': 0,
            'mute': 0,
            'autoplay': 1
          },
          events: {
            onReady: that.onPlayerReady,
            onStateChange: that.onPlayerStateChange
          }
        });
      }
      if (this.play === false) {
        this.player.stopVideo()
        this.player.destroy()
      }
    },
    onPlayerReady(evt) {
      evt.target.setVolume(this.volume);
      evt.target.playVideo();
    },
    onPlayerStateChange(evt) {
      if (evt.data === 0) {
        if (this.loop === 1) {
          this.player.playVideo(); 
        }
      }
    },
  },
}).mount("#YoutubeAudioPlayer");