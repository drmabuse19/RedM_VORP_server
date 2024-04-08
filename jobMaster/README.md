# jobMaster
Redm rp script to configure many job in many configurable way. One script for all (or at least many of them).
This script was designed to not have to make 1 script by "farming" type job (mining, farming, deliverying or any "simple" type job)

You have some easy example job already done in the code. Go add all the job you want in the config.lua for your server.

## Configuration

### Job
For each job you have to write some entry listed here
| Parameter name | Description | Required | 
|----------------|-------------|----------|
| vehicule | Value of the model for the deliverying car. Only needed if you want delevery for the job. | false |
| jobName | Value of the job title the player need to start this job | true |
| init | Coordinate to trigger the starting job message | true |
| farm | List of the action the player have to do during the job. anim is the animation name you want to show, time is the time the animation will play and text is the text you will view in the progress bar | true |
| vehiculeSpawn | List of coordinate for vehicule spawn. Only the first one work atm. Only need to put coordinate if you want delivery for your job. Otherwise, write an empty list | false |
| livraison | Delivery coordinate, or if you want the spot to end the job and get paid | true |
| money | How many you want player to get paid. You can random the paid if you put different number | true |
| xp | Same as money but for xp | true |
| animationVehicule | The animation when you stock in the delivery car. Only needed if you have delivery. | false |
| VehiculeTime | Time during the animationVehicule will play | false |
| blipsMap | Some info to show the position of the job on the maps | true |

### Job title
| Parameter name | Description |
|----------------|-------------|
| title | Title for the job |
| startWorkMsg | Message you want to show to the player to change their job to this one |
| pos | List of coordinate where you can change to this job |
