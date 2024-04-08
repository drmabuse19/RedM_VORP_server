
<template>
    <div @mouseup="stopMilking">
        <div class="game-container">
            <div :class="`cow ${milking ? 'milk-animation' : ''}`" @mousedown="startMilking" @mouseup="stopMilking">Utter</div>

            <div class="data-display animate__animated animate__backInUp">
                <div class="controls">
                    <div class="timer">
                        <svg xmlns="http://www.w3.org/2000/svg" style="vertical-align: middle; fill:#ffffff;" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M464 256A208 208 0 1 1 48 256a208 208 0 1 1 416 0zM0 256a256 256 0 1 0 512 0A256 256 0 1 0 0 256zM232 120V256c0 8 4 15.5 10.7 20l96 64c11 7.4 25.9 4.4 33.3-6.7s4.4-25.9-6.7-33.3L280 243.2V120c0-13.3-10.7-24-24-24s-24 10.7-24 24z"/></svg>
                        <span style="vertical-align: middle; margin-left: 10px;">{{ timer }}</span>
                    </div>
                    <div class="score">
                        <img height="26" style="vertical-align: middle;" src="../assets/img/milk.png"/>
                        <span style="vertical-align: middle; margin-left: 10px;">{{ score.toFixed(2) }} Liters</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
  
<script>
// import api from "../api";
import 'animate.css';

export default {
    name: 'CowMilker',
    props: {
        config: { type: Object, required: true }
    },
    data() {
        return {
            score: 0,
            timer: 0,
            gameOver: false,
            milking: false,
            milkingInterval: null,
            maxMilkForSession: 0,
            currentMilkForSession: 0,
            milkheight: 10
        };
    },
    methods: {
        startMilking() {
            if (!this.gameOver && !this.milking) {
                this.milking = true;

                this.maxMilkForSession = this.randomRange(this.config.minMilkPerSqueez || 0.1, this.config.maxMilkPerSqueez || 0.4);
                this.currentMilkForSession = 0;
                this.milkingInterval = setInterval(() => {
                    if (this.currentMilkForSession < this.maxMilkForSession) {
                        let inc = 0.01;
                        this.score += inc;
                        this.currentMilkForSession += inc;
                    }
                }, 100);
            }
        },
        randomRange(min, max) {
            let cal = (Math.random() * (max - min) + min);
            return parseFloat(cal);
        },
        stopMilking() {
            if (this.milking) {
                clearInterval(this.milkingInterval);
                this.milking = false;
            }
        },
        SetupGame() {
            this.score = 0;
            this.timer = this.config.timer || 30;
            this.currentMilkForSession = 0;
            this.gameOver = false;
            this.countdown();
        },
        countdown() {
            if (this.timer > 0) {
                setTimeout(() => {
                    this.timer--;
                    this.countdown();
                }, 1000);
            } else {
                this.gameOver = true;
                setTimeout(() => {
                    this.$emit('result', { collected: this.score })
                }, 1000);
            }
        },
    },
    mounted() {
        this.SetupGame();
    },
}
</script>
 
<style scoped>
.game-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;

    color: white;
}

.cup {
    width: 200px;
    height: 500px;
    border: 3px solid red;

    position: relative;
}

.milk {
    background-color: white;
    width: 100%;
    /* height: 100%; */
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
}

.cow {
    position: absolute;
    top: -5%;
    left: 50%;
    transform: translate(-50%, -5%);
    width: 290px;
    height: 250px;
    background-image: url('../assets/img/utter.png');
    background-size: contain;
    background-repeat: no-repeat;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.cow:hover {
    position: absolute;
    top: -4%;
    left: 50%;
    transform: translate(-50%, -4%);
}

.controls {
    background-color: rgba(0, 0, 0, 0.658);
    padding: 10px;
    border-radius: 6px;
}

.timer {
    font-size: 24px;
    margin-bottom: 16px;
    text-align: left;
}

.score {
    font-size: 18px;
    text-align: left;
}

.milk-animation {
    position: absolute;
    top: -4%;
    left: 50%;
    animation: wiggle 2.5s infinite;
}

@keyframes wiggle {
    0% { transform: translate(-50%, -4%) rotate(0deg); }
    45% { transform: translate(-50%, -4%) rotate(5deg); }
   55% { transform: translate(-50%, -4%) rotate(-5deg); }
   80% { transform: translate(-50%, -4%) rotate(0deg); }
   85% { transform: translate(-50%, -4%) rotate(5deg); }
   95% { transform: translate(-50%, -4%) rotate(-5deg); }
  100% { transform: translate(-50%, -4%) rotate(0deg); }
}

</style>