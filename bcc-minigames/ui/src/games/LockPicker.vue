<template>
    <div class="lock animate__animated animate__zoomIn" ref="lock">
        <div class="lockpick" ref="lockpick" v-if="!unlocked && !lose"></div>
        <div class="center-icon" v-show="!unlocked">
            <svg style="width: 50px; height: 50px;  fill: white;" :class="{ 'animate__animated animate__shakeX': errorhit }"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 448 512"><!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                <path
                    d="M144 144v48H304V144c0-44.2-35.8-80-80-80s-80 35.8-80 80zM80 192V144C80 64.5 144.5 0 224 0s144 64.5 144 144v48h16c35.3 0 64 28.7 64 64V448c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V256c0-35.3 28.7-64 64-64H80z" />
            </svg>
        </div>
        <div class="center-icon" v-show="unlocked">
            <svg style="width: 50px; height: 50px;  fill: white;" xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 576 512"><!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                <path
                    d="M352 144c0-44.2 35.8-80 80-80s80 35.8 80 80v48c0 17.7 14.3 32 32 32s32-14.3 32-32V144C576 64.5 511.5 0 432 0S288 64.5 288 144v48H64c-35.3 0-64 28.7-64 64V448c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V256c0-35.3-28.7-64-64-64H352V144z" />
            </svg>
        </div>
        <div class="ring shake-constant" :class="{ 'shake-little': shake }"></div>
        <ul class="stage">
            <li v-for="(stage, index) in stages" :key="'stage' + index" :class="{ 'active': stage.active }"
                :data-deg="stage.deg"></li>
        </ul>
    </div>
</template>
  
<script>
export default {
    props: {
        config: { type: Object, required: true }
    },
    data() {
        return {
            timer: null,
            timerset: false,
            timer_error: null,
            timerset_error: false,
            lock: null,
            lockpick: null,
            activeStage: null,
            activeIndex: 0,
            shake: false,
            leftcarrot: false,
            rightcarrot: false,
            unlocked: false,
            inzone: false,
            lose: false,
            maxattempts: 3,
            threshold: 10,
            hintdelay: 500,
            attempts: 1,
            errorhit: false,
            stages: [],
            busytime: 0,
            busy: false
        }
    },
    mounted() {
        this.maxattempts = this.config?.maxattempts || 3 
        this.threshold = this.config?.threshold || 10
        this.hintdelay = this.config?.hintdelay || 500

        if (this.config?.stages && this.config.stages.length > 0) {
            for (let index = 0; index < this.config.stages.length; index++) {
                const stage = this.config.stages[index];

                this.stages.push({
                    deg: stage.deg,
                    active: false
                })
            }
            document.addEventListener("mousemove", this.handleMouseMove);
            document.addEventListener("click", this.handleMouseClick);
            this.lock = this.$refs['lock'];
            this.activeStage = this.stages[0]
        } else {
            console.log('Must have at least 1 stage defined.')
        }
    },
    beforeUnmount() {
        document.removeEventListener("mousemove", this.handleMouseMove);
        document.removeEventListener("click", this.handleMouseClick);
    },
    methods: {
        UnRegister() {
            document.removeEventListener("mousemove", this.handleMouseMove);
            document.removeEventListener("click", this.handleMouseClick);
        },
        handleMouseClick() {
            if (this.busytime === 0) {
                this.busytime++
                this.errorhit = false
                clearInterval(this.timer_error)
                this.timerset_error = false


                if (this.lose) return

                if (this.inzone) {
                    this.shake = false
                    this.stages[this.activeIndex].active = true

                    if (this.activeIndex < this.stages.length - 1) {
                        // Next stage
                        this.activeIndex++
                        this.activeStage = this.stages[this.activeIndex]
                        this.attempts = 1
                    } else {
                        this.unlocked = true
                        this.UnRegister()

                        setTimeout(() => {
                            this.$emit('result', { unlocked: true })
                        }, 1500);
                    }
                } else {
                    this.unlocked = false
                    this.attempts++

                    this.errorhit = true
                    if (!this.timerset_error) {
                        this.timer_error = setTimeout(() => {
                            this.errorhit = false
                        }, 1000);

                        this.timerset_error = true
                    }


                    if (this.attempts > this.maxattempts) {
                        this.lose = true
                        this.UnRegister()

                        setTimeout(() => {
                            this.$emit('result', { unlocked: false })
                        }, 1500);
                    }
                }


                // Prevents spam click cheat'n
                setTimeout(() => {
                    this.busytime = 0
                }, 1000);
            }
        },
        handleMouseMove(event) {
            if (this.unlocked || this.lose) return

            const lockEl = this.$refs.lock;
            const deg = this.angle(
                lockEl.offsetLeft + lockEl.offsetWidth / 2,
                lockEl.offsetTop + lockEl.offsetHeight / 2,
                event.pageX,
                event.pageY
            );

            lockEl.querySelector(".lockpick").style.transform = `rotate(${deg + 90}deg)`;

            let activelockposition = this.activeStage.deg

            if (deg <= activelockposition + this.threshold && deg >= activelockposition - this.threshold) {
                this.inzone = true
                if (!this.timerset) {
                    this.timer = setTimeout(() => {
                        this.shake = true
                    }, this.hintdelay);

                    this.timerset = true
                }


            } else {
                this.shake = false
                this.inzone = false
                clearInterval(this.timer)
                this.timerset = false
            }
        },
        angle(cx, cy, ex, ey) {
            var dy = ey - cy;
            var dx = ex - cx;
            var theta = Math.atan2(dy, dx); // range (-PI, PI]
            theta *= 180 / Math.PI; // rads to degs, range (-180, 180]
            if (theta < 0) theta = 360 + theta; // range [0, 360)
            return theta;
        }
    }
};
</script>
<style scoped>
.lock {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 200px;
    height: 200px;
}

.lock .ring {
    position: absolute;
    border: 5px solid rgba(255, 255, 255, 0.5);
    width: 100%;
    height: 100%;
    border-radius: 100%;
    top: 0;
    left: 0;
    box-sizing: border-box;

    box-shadow: 0px 0px 20px #919191;
}

.lock .lockpick {
    position: absolute;
    width: 4px;
    height: 100px;
    background: black;
    left: 50%;
    top: 0px;
    margin-left: -2px;
    background: rgb(214, 159, 5);
    transform-origin: bottom;

    /* z-index: 9; */
}

svg {
    stroke: #000000;
    z-index: 9999;
}

.lock .stage {
    position: absolute;
    bottom: -40%;
    left: 35%;
    transform: translate(-35%, -40%);
}

.lock .stage li {
    width: 10px;
    height: 25px;
    background: rgba(255, 255, 255, 0.5);
    float: left;
    margin: 0 2px;
    border-radius: 5px;
    transition: all 1s ease;
    text-decoration: none;
    list-style-type: none;

    box-shadow: 0px 0px 20px #919191;
}

.lock .stage li.active,
.lock .stage li.done {
    background: #0eac1e;
    margin-top: -10px;
}

.lock .stage li.done {
    margin-top: -20px;
}

.center-icon {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

@keyframes error-pulse {
    0% {
        transform: rotate(0deg) scale(1);
    }

    40% {
        transform: rotate(10deg) scale(1.2);
    }

    100% {
        transform: rotate(0deg) scale(1);
    }

}


@keyframes shake-little {
    2% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    4% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    6% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    8% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    10% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    12% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    14% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    16% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    18% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    20% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    22% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    24% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    26% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    28% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    30% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    32% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    34% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    36% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    38% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    40% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    42% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    44% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    46% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    48% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    50% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    52% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    54% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    56% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    58% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    60% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    62% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    64% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    66% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    68% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    70% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    72% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    74% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    76% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    78% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    80% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    82% {
        transform: translate(1px, 0px) rotate(0.5deg);
    }

    84% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    86% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    88% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    90% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    92% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    94% {
        transform: translate(1px, 1px) rotate(0.5deg);
    }

    96% {
        transform: translate(0px, 1px) rotate(0.5deg);
    }

    98% {
        transform: translate(0px, 0px) rotate(0.5deg);
    }

    0%,
    100% {
        transform: translate(0, 0) rotate(0);
    }
}


.error-pulse:hover,
.error-pulse:hover .error-pulse,
.error-pulse,
.error-pulse.shake-freeze,
.error-pulse.shake-constant {
    animation-name: error-pulse;
    animation-duration: 1s;
    animation-timing-function: ease-in-out;
    animation-iteration-count: infinite;
}

.shake-little:hover,
.shake-trigger:hover .shake-little,
.shake-little.shake-freeze,
.shake-little.shake-constant {
    animation-name: shake-little;
    animation-duration: 100ms;
    animation-timing-function: ease-in-out;
    animation-iteration-count: infinite;
}
</style>