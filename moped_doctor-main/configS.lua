Config = {}

Config.Framework = 'vorp' -- redemrp, vorp or standalone. To use your own framework look into the 'moped_doctor:checkin' server event. -- STANDALONE = a patch up from the doctor will be free - no framework needed for the whole script. -- CAN ALSO USE IF YOU'RE USING VORP/REDEMRP BUT WANT PEOPLE TO USE DOCTOR FOR FREE -- wont work with JobCheck for obvious reasons
Config.Money = 30 -- How many dollars should it cost to get patched up?

Config.JobCheck = true -- should there be a check if players with a job are online?
Config.JobName = {'lege', 'overlege'} -- jobname used in code -- can use multiple or just one (has to be in a table {})
Config.JobCount = 2 -- how many players with the job need to be online before it tells the client to find the player doctor?