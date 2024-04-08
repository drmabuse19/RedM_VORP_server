<template>
    <div>
        <Lockpicker v-if="game == 'lockpick'" :config="config" @result="handleResults"></Lockpicker>
        <RockPaper v-if="game == 'rps'" :config="config" @result="handleResults"></RockPaper>
        <SkillCheck v-if="game == 'skillcheck'" :config="config" @result="handleResults"></SkillCheck>
        <HammerDown v-if="game == 'hammertime'" :config="config"  @result="handleResults"></HammerDown>
        <CowMilker v-if="game == 'cowmilker'" :config="config"  @result="handleResults"></CowMilker>
    </div>
</template>
<script>
import RockPaper from './games/RockPaper.vue';
import SkillCheck from './games/SkillCheck.vue';
import Lockpicker from './games/LockPicker.vue';
import HammerDown from './games/HammerDown.vue';
import CowMilker from './games/CowMilker.vue';

import api from './api'

import 'animate.css';

export default {
    name: 'DefaultLayout',
    data() {
        return {
            game: null,
            config: {}
        }
    },
    components: {
        RockPaper,
        SkillCheck,
        Lockpicker,
        HammerDown,
        CowMilker
    },
    mounted() {
        this.mlistener = window.addEventListener("message", this.onMessage);
    },
    unmounted() {
        // Remove listeners when UI is destroyed to save on memory
        if (this.mlistener) window.removeEventListener("message");
    },
    methods: {
        reset() {
            this.game = null
            this.config = {}
        },
        handleResults(data) {
            this.reset()

            api.post("result", data).catch(e => {
                console.log(e.message)
            });
        },
        onMessage(event) {
            switch (event.data.action) {
                case "start":
                    this.game = event.data.game
                    this.config = event.data.config
                    break;
                case "stop":
                    this.reset()
                    break;
                default:
                    break;
            }
        }
    }
}
</script>
<style lang="scss">
@font-face {
    font-family: rdr;
    src: url(assets/fonts/rdrlino-regular-webfont.woff);
}


#app {
    font-family: rdr, Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    overflow: hidden;
    user-select: none;
}

html,
body {
    overflow: hidden;
}
</style>
