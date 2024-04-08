import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from 'axios';
function BuyRideMenu({ rideType, currentRidesList }) {
  const [displayedRide, setDisplayedHorse] = useState(null);
  const [currentCat, setCurrentCat] = useState(null);
  const [currentCatName, setCurrentCatName] = useState(null);
  const [timer, setTimer] = useState(true);
  const setRoute = useContext(RouteCtx)
  useEffect(() => {
    document.onkeydown = (e) => {
      if (e.key === "Backspace") {
        currentCat !== null
          ? setCurrentCat(null)
          : setRoute("/");
      }
    }

    axios.post(`https://${GetParentResourceName()}/activateCam`, { rideType })

  });

  function showRideAndPromptValidation(rideName) {
    if (!timer) return;
    axios.post(`https://${GetParentResourceName()}/showRide`, {
      rideType,
      rideName
    })
    setDisplayedHorse(rideName);
    setTimer(false);
    setTimeout(() => setTimer(true), 500)
  }

  function DisplayRidesFromType() {
    let obj;
    switch (rideType) {
      case RideTypes.horse:
        obj = currentCat || formatRidesObject(currentRidesList.horses, rideType);
        return Object.keys(obj).length >= 10 && !currentCat
          ? categorize(obj, rideType)
          : Object.entries(obj).map(DisplayNoNesting);
      case RideTypes.cart:
        obj = currentCat || formatRidesObject(currentRidesList.carts, rideType);
        return Object.keys(obj).length >= 10 && !currentCat
          ? categorize(obj, rideType)
          : Object.entries(obj).map(DisplayNoNesting);
    }
  }

  function formatRidesObject(obj, rideType) {
    const retVal = {}
    for(const val in obj) {
      if(!isNaN(Number(val))) {
        retVal[obj[val]] = Data[rideType == RideTypes.horse ? "Horses" : "Carts"][obj[val]];
      }
      else retVal[val] = obj[val];
    }
    return retVal
  }

  function categorize(rides, rideType) {
    const categories = {};
    const others = ["A_C_HorseMulePainted_01", "A_C_HorseMule_01", "A_C_Horse_MP_Mangy_Backup"]
    if (rideType == RideTypes.horse) {
      Object.entries(rides).forEach(([rideName, ridePrice]) => {
        if (!rideName) return;
        if (others.includes(rideName)) {
          categories.others ? categories.others[rideName] = ridePrice : categories.others = { [rideName]: ridePrice };
          return;
        }
        const upRideName = rideName.toUpperCase();
        let cat = upRideName.split("A_C_HORSE_")[1]?.split("_")[0]
        if (cat) {
          categories[cat] ? categories[cat][rideName] = ridePrice : categories[cat] = { [rideName]: ridePrice };
          return;
        }
      });
      return Object.entries(categories).sort((a,b) => a[0].localeCompare(b[0])).map(([catName, catObj]) => <span key={catName} onClick={(e) => {
        setCurrentCat(catObj)
        setCurrentCatName(catName)
      }}>
        <label>{Data.Lang[catName] || catName}</label>
      </span>
      )
    }
    else if (rideType == RideTypes.cart) {
      const cartTypes = [
        "buggy",
        "cart",
        "chuckwagon",
        "wagon",
        "coach",
        "stagecoach",
        "logwagon",
        "supplywagon",
      ]
      Object.entries(rides).forEach(([rideName, ridePrice]) => {
        if (!rideName) return;
        for (const cat of cartTypes) {
          if(rideName.startsWith(cat)){
            categories[cat] ? categories[cat][rideName] = ridePrice : categories[cat] = { [rideName]: ridePrice };
            return;
          }
        }
        categories.others ? categories.others[rideName] = ridePrice : categories.others = { [rideName]: ridePrice };
      });
      return Object.entries(categories).sort((a,b) => a[0].localeCompare(b[0])).map(([catName, catObj]) => <span key={catName} onClick={(e) => {
        setCurrentCat(catObj)
        setCurrentCatName(catName)
      }}>
        <label>{Data.Lang[catName] || catName}</label>
      </span>
      )
    }
  }

  function DisplayNoNesting([rideModel, price]) {
    return <span key={rideModel} onClick={(e) => {
      e.stopPropagation();
      displayedRide !== rideModel && showRideAndPromptValidation(rideModel, price);
    }}>
      <label>{Data.Lang[rideModel] || rideModel}</label>
      {
        displayedRide === rideModel
          ? <button onClick={(e) => {
            e.stopPropagation();
            axios.post(`https://${GetParentResourceName()}/buyRide`, {
              rideType,
              rideModel,
              price
            })
          }}>{Data.Lang.BuyFor.replace("{price}", price)}</button>
          : <i className="price">{Data.Lang.DollarBeforeOrAfterPrice.replace("{price}", price)}</i>
      }
    </span>
  }



  return (
    <div className="menu-wrap">
      <h1>{
        currentCat
          ? `${Data.Lang.BuyA} ${currentCatName}`
          : `${rideType === RideTypes.horse ? Data.Lang.BuyA : Data.Lang.BuyA2} ${rideType === RideTypes.horse ? Data.Lang.horse : Data.Lang.cart}`
      }</h1>
      <menu>
        <DisplayRidesFromType />
      </menu>
    </div>
  )
}
const RideTypes = {
  cart: "cart",
  horse: "horse"
}
export default BuyRideMenu;
export {
  RideTypes
}