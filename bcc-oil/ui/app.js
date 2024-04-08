const { createApp } = Vue //loads vue

createApp({ //creates an app
  data() { //sets data that is too be used in the app
    return { //returns the data/sets it
      showing: false, //sets showing to false (this is used in the html too hide the ui until)
      showing2: false, //same as above but for the oil menu part of the ui
      showing3: false,
      config: {},
      crimshowing: false,
      exited: false //this variable is used to detect if you choose the exit option
    }
  },
  mounted() { //this will run once the app.js is mounted fully ready too go
    window.addEventListener('message', this.onMessage); //creates an event lister so it will listen too any nui events that run
  },
  destroyed() { //this will just delete them once they run too keep it optimized
    window.removeEventListener('message') //deletes the message listener
  },
  methods: { //this is where you set methods(what certain events will do when called on)
    onMessage(event) { //creates an event named on message
      if (event.data.type === 'open') { //if the data passed too it is the string open then
        this.config = event.data.config //sets the config variable in js too equal teh table in config.lua
        this.language = event.data.language
        this.showing2 = true //sets the variable too true allowing the ui in html too show
      }
      if (event.data.type === 'open2') { //if the type passed is open 2 then
        this.config = event.data.config
        this.language = event.data.language
        this.crimshowing = true //sets the variable too true allowing the crim menu too show
      }
    },
    buyoilwagon() { //new method when ran in the html
      fetch(`https://${GetParentResourceName()}/BuyOilWagon`, { //triggers the nui callback in menusetups.lua that buys the wagon (all methods below do the same just trigger different callbacks)
      })
    },
    selloilwagon() {
      fetch(`https://${GetParentResourceName()}/SellOilWagon`, {
      })
    },
    oildeliverymission() {
      fetch(`https://${GetParentResourceName()}/OilDeliveryMission`, {
      })
    },
    buysupplywagon() {
      fetch(`https://${GetParentResourceName()}/BuySupplyWagon`, {
      })
    },
    sellsupplywagon() {
      fetch(`https://${GetParentResourceName()}/SellSupplyWagon`, {
      })
    },
    supplydeliverymission() {
      fetch(`https://${GetParentResourceName()}/SupplyDelivery`, {
      })
    },
    roboilwagon() {
      fetch(`https://${GetParentResourceName()}/RobOilWagon`, {
      })
    },
    roboilco() {
      fetch(`https://${GetParentResourceName()}/RobOilCompany`, {
      })
    },
    openManagerOilMenu() { //creates a new method
      this.showing = true //changes variable to this when called
      this.showing2 = false //same as above
      this.showing3 = false
    },
    onExitMenu() { //new method created
      this.showing = false //changes these variables when called, hides the menu
      this.showing2 = false //changes variable which hides the menu
      this.showing3 = false
      this.crimshowing = false
      fetch(`https://${GetParentResourceName()}/closemenu`, { //triggers the callback in menusetups.lua to disable nui focus
      })
    },
    openManagerSupplyMenu() { //new method that when ran will change variables
      this.showing = false
      this.showing2 = false
      this.showing3 = true
    }
  },
}).mount('#app') //mounts this app too the #app id in index.html