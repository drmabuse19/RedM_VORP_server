<template>
    <div class="container-wrap animate__animated animate__backInDown">
        <canvas ref="canvas"></canvas>
        <div class="middle">
            <div v-if="!showx && !winner">{{ key_to_press }}</div>
            <svg v-show="showx" class="animate__animated animate__heartBeat miss" xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 384 512"><!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                <path
                    d="M342.6 150.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 210.7 86.6 105.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L146.7 256 41.4 361.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L192 301.3 297.4 406.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L237.3 256 342.6 150.6z" />
            </svg>
            <svg v-show="winner" class="animate__animated animate__tada check" xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 448 512"><!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                <path
                    d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z" />
            </svg>
        </div>
    </div>
</template>
  
<script>
import 'animate.css';
/**TODO:
 * - Multiple Quadrants
 */

export default {
    name: 'SkillCheck',
    props: {
        config: { type: Object, required: true }
    },
    data() {
        return {
            inzone: false,
            is_setup: false,
            attempts: 1,
            maxattempts: 3,
            failed: false,
            winner: false,
            interval: null,
            strict: false,
            speed: 20,
            showx: false,
            key_to_press: 'B',
            key_code: 66,
            use_random_key_code: true,
            type: 'bar' // trailing, bar
        }
    },
    mounted() {
        this.type = this.config?.type || 'bar'
        this.maxattempts = this.emptycheck(this.config.maxattempts) ? this.config.maxattempts : 3
        this.use_random_key_code = this.emptycheck(this.config.userandomkey) ? this.config.userandomkey : true
        this.speed = this.emptycheck(this.config.speed) ? this.config.speed : 20
        this.strict = this.config.strict || false
        if (this.config?.keytopress && this.config?.keycode) {
            this.key_to_press = this.config?.keytopress
            this.key_code = this.config?.keycode
        }

        window.addEventListener("keydown", this.onKeydown);

        const canvas = this.$refs.canvas
        var size = 200;
        canvas.style.width = size + "px";
        canvas.style.height = size + "px";

        // Set actual size in memory (scaled to account for extra pixel density).
        var scale = window.devicePixelRatio;
        canvas.width = size * scale;
        canvas.height = size * scale;
        const context = canvas.getContext('2d')
        const radius = 60
        const centerX = canvas.width / 2
        const centerY = canvas.height / 2
        context.scale(scale, scale);

        let start = 0
        let end = 0
        let angle = 0

        this.interval = setInterval(() => {
            if (!this.is_setup) {
                this.failed = false
                this.is_setup = true
                this.attempts = 1

                if (this.use_random_key_code) {
                    this.key_code = this.generateRandomKeyCode()
                    this.key_to_press = String.fromCharCode(this.key_code);
                }

                start = this.getRandomInt(0, 52) / 10;
                end = start + this.getRandomInt(5, 10) / 10;

                angle = 0
            }

            // Clear the frame
            context.clearRect(0, 0, canvas.width, canvas.height);

            // Drop Shadow
            context.shadowColor = "grey";
            context.shadowBlur = 30;
            context.shadowOffsetX = 2;
            context.shadowOffsetY = 2;

            // Draw the circle
            context.beginPath()
            context.strokeStyle = '#fff';
            context.lineWidth = 20;
            context.arc(centerX, centerY, radius, 0, 2 * Math.PI)
            context.stroke();


            // Clear shaddow
            context.shadowBlur = 0;
            context.shadowOffsetX = 0;
            context.shadowOffsetY = 0;

            // Draw the target quadrant in a different color
            context.beginPath();
            context.strokeStyle = '#59b130';
            context.lineWidth = 20;
            context.arc(centerX, centerY, radius, start - (90 * Math.PI) / 180, end - (90 * Math.PI) / 180, false);
            context.stroke();


            // Set Orbiter Shaddow
            context.shadowBlur = 6;
            context.shadowOffsetX = 2;
            context.shadowOffsetY = 2;

            // Set Orbitter length
            let startType = angle
            if (this.type === 'trailing') {
                startType = 0
            }

            // Orbiter
            context.beginPath();
            context.strokeStyle = '#9e1d1dcf';
            context.lineWidth = 20;
            context.arc(centerX, centerY, radius, (startType - 0.1) - (90 * Math.PI) / 180, angle - (90 * Math.PI) / 180, false);
            context.stroke();


            // Collision Detection
            if (angle < start || angle > end) {
                this.inzone = false
            } else {
                this.inzone = true
            }

            if (angle >= (2 * Math.PI)) {
                // Reset as the angle is now maximum of a circle
                angle = 0

                if (this.strict) {
                    this.checkWinCondition()
                }
            } else {
                angle += 0.019;
            }
        }, this.speed)

    },
    methods: {
        emptycheck(t) {
            return !(t == null || typeof t == 'undefined')
        },
        generateRandomKeyCode() {
            const min = 48;
            const max = 90;
            const keyCode = Math.floor(Math.random() * (max - min + 1)) + min;
            if (keyCode >= 58 && keyCode <= 64) {
                // exclude characters that are not A-Z or 0-9
                return this.generateRandomKeyCode();
            }
            return keyCode;
        },
        getRandomInt(min, max) {
            min = Math.ceil(min);
            max = Math.floor(max);
            return Math.floor(Math.random() * (max - min + 1) + min);
        },
        checkWinCondition() {
            if (this.inzone) {
                // PASSED!
                // this.is_setup = false
                this.winner = true
                if (this.interval) clearInterval(this.interval)

                setTimeout(() => {
                    this.$emit('result', { passed: true })
                }, 2300);
            } else if (this.attempts >= this.maxattempts) {
                // HARD FAIL
                this.failed = true
                this.showx = true
                if (this.interval) clearInterval(this.interval)

                setTimeout(() => {
                    this.$emit('result', { passed: false })
                }, 2300);
            } else {
                // FAILED ATTEMPT
                this.attempts++
                this.showx = true

                setTimeout(() => {
                    this.showx = false
                    if (this.use_random_key_code) {
                        this.key_code = this.generateRandomKeyCode()
                        this.key_to_press = String.fromCharCode(this.key_code);
                    }
                }, 800);
            }
        },
        onKeydown(e) {
            if (e.keyCode == this.key_code) {
                this.checkWinCondition()
            }
        }
    }
}
</script>
<style scoped>
.container-wrap {
    position: relative;
}

.middle {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #ffffffb5;
    border-radius: 100%;

    line-height: 40px;

    width: 40px;
    height: 40px;
    box-shadow: 0px 0px 20px #b5b5b5;
}

.miss {
    width: 40px;
    height: 40px;
    fill: #af4c4c;
}

.check {
    width: 40px;
    height: 40px;
    fill: #1d9e30;
}
</style>