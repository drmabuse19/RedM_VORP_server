import { useContext, useEffect } from "react"
import { Data, RouteCtx } from "./App"
import axios from "axios";

function MainMenu({ transferedRides, rides }) {
  const setRoute = useContext(RouteCtx);
  useEffect(() => {
    document.onkeydown = (e) => {
      if (e.key === "Backspace") {
        axios.post(`https://${GetParentResourceName()}/exit`);
        setRoute("/exit");
      }
    }
  }, [])

  const currentChar = Data.characters.find(c => c.charidentifier === Data.player.characterId);
  console.log(currentChar.job, Data.JobForCartDealer,Data.JobForHorseDealer)
  return (
    <div className="menu-wrap">
      <h1>{Data.Lang.Stable}</h1>
      <menu>
        {
          !Data.DisableBuyOption &&
          (
            !Data.JobRequired ||
            currentChar.job === Data.JobForHorseDealer ||
            currentChar.job === Data.JobForAllDealer
          ) &&
          <span onClick={() => setRoute("/buyhorse")}>{Data.Lang.BuyAHorse}</span>
        }
        {
          !Data.DisableBuyOption &&
          (
            !Data.JobRequired ||
            currentChar.job === Data.JobForCartDealer ||
            currentChar.job === Data.JobForAllDealer
          ) &&
          <span onClick={() => setRoute("/buycart")}>{Data.Lang.BuyACart}</span>
        }
        {
          rides && rides.length
            ? <span onClick={() => setRoute("/myrides")}>{Data.Lang.MyRides}</span>
            : null
        }
        {
          transferedRides && transferedRides?.length
            ? <span onClick={() => setRoute("/recieve")}>{Data.Lang.RidesAwaitingTransfer}</span>
            : null
        }
      </menu>
    </div>
  )
}

export default MainMenu