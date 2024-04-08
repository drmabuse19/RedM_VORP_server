<template>
    <div>
        <div class="wood-plank" :class="wood_type">
            <table class="nail-board" v-if="!win">
                <tbody v-show="ready">
                    <tr v-for="(row, rowIndex) in nail_slots" :key="rowIndex">
                        <td v-for="(cell, cellIndex) in row" :key="cellIndex">
                            <div class="nail-poll" @click="hammerNail(rowIndex, cellIndex, cell)">
                                <div class="nail" :class="{ nailed: cell }" v-if="cell !== null"></div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="winner" v-show="win">
            <svg class="animate__animated animate__tada check" xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 448 512"><!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                <path
                    d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z" />
            </svg>
        </div>
    </div>
</template>
  
<script>
import 'animate.css';
import hammertime from '../assets/media/HammerHit.mp3'
import hammermiss from '../assets/media/HammerMiss.mp3'

export default {
    name: 'RockPaper',
    props: {
        config: { type: Object, required: true }
    },
    data() {
        return {
            rows: 10,
            cols: 32,
            nail_slots: [],
            nail_count: 10,
            nailed: 0,
            win: false,
            ready: false,
            wood_type: 'light-wood' //light-wood, medium-wood, dark-wood
        }
    },
    mounted() {
        this.nail_count = this.config?.nails || 10
        this.wood_type = this.config?.type || 'light-wood'

        this.createNails()
    },
    methods: {
        createNails() {
            const availableSlots = []
            this.nail_slots = Array.from({ length: this.rows }, (v, x) => Array.from({ length: this.cols }, (v, y) => {
                availableSlots.push([x, y])
                return null //default value
            }))

            for (let i = 0; i < this.nail_count; i++) {
                const index = Math.floor(Math.random() * availableSlots.length)
                const [row, col] = availableSlots[index]
                this.nail_slots[row][col] = false
                availableSlots.splice(index, 1)
            }

            this.ready = true;
        },
        hammerNail(row, col, cell) {
            if (cell === false) {
                new Audio(hammertime).play()

                this.nail_slots[row][col] = true
                this.nailed++
                if (this.nailed === this.nail_count) {
                    this.win = true
                    setTimeout(() => {
                        this.$emit('result', { result: true })
                    }, 1000);
                }
            } else {
                new Audio(hammermiss).play()
            }
        }
    }
}
</script>
<style scoped>
.light-wood {
    background-image: url('../assets/img/lightwood.png');
}

.medium-wood {
    background-image: url('../assets/img/mediumwood.png');
}

.dark-wood {
    background-image: url('../assets/img/darkwood.png');
}

.wood-plank {
    height: 200px;
    width: 600px;

    position: absolute;
    top: 30%;
    left: 50%;

    transform: translate(-50%, -30%);
}

.nail-board {
    position: absolute;
    top: 50%;
    left: 50%;

    transform: translate(-50%, -50%);
}

.nail-poll {
    width: 14px;
    height: 14px;
    border-radius: 100%;
}

.nail {
    width: 100%;
    height: 100%;
    border-radius: 100%;
    background-color: #8b8787;
    transform: scale(1.2);
    transition: all 0.3s ease;
    cursor: pointer;
}

.nailed {
    background-color: #565454;
    transform: scale(1);
    transition: all 0.3s ease;
}

.dark-wood .nail {
    background-color: #bbb7b7;
}

.dark-wood .nailed {
    background-color: #898787;
}

.winner {
    position: absolute;
    top: 35%;
    left: 50%;

    transform: translate(-50%, -35%);
}

.check {
    width: 40px;
    height: 40px;
    fill: #1d9e30;
}
</style>

<!-- 
    - Hammer noise
    - Miss Noise (guy yellin' or something)
-->