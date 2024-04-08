
import MainMenu from './MainMenu'
import "./styles/main.sass"
import BuyRideMenu, { RideTypes } from './BuyRideMenu'
import { createContext, useEffect, useState } from 'react'
import MyRidesMenu from './MyRidesMenu';
import BuyCompsMenu from './BuyCompsMenu';
import TransferModal from './TransferMenu';
import TransferRecieve from './TransferRecieve';
let Data = {};
const RouteCtx = createContext();

function App() {
  const [m_Data, setM_Data] = useState(Data);
  const [display, setDisplay] = useState(false);
  const [route, setRoute] = useState("/");
  useEffect(setupMessageReciever);
  function setupMessageReciever() {
    window.addEventListener("message", (mess) => {
      const { type, content } = JSON.parse(mess.data);
      if (type === "registerConfig") {
        Data = {
          ...Data,
          ...content,
          ...content.StaticData,
          StaticData: null
        }
        setM_Data(Data);
      }
      else if (type === "open") {
        setDisplay(true);
        Data.player = content.player;
        Data.current = content.current;
        setM_Data({ ...Data });
      }
      else if (type === "refresh") {
        if (Data == null) return;
        Data.player = content.player;
        Data.current = content.current;
        setM_Data({ ...Data });
      }
      else if (type === "refreshChars") {
        Data.characters = content;
        setM_Data({ ...Data });
      }
    });
  }

  function exit() {
    setDisplay(false);
    setRoute("/");
  }

  if (Data === null || !display) return;
  else if (route === "/myrides" && !m_Data.player?.rides.length) return setRoute("/");
  else return (
    <RouteCtx.Provider value={setRoute}>
      {
        route === "/" && <MainMenu transferedRides={m_Data.player?.transferedRides} rides = {m_Data.player?.rides}/> ||
        route === "/buyhorse" && <BuyRideMenu rideType={RideTypes.horse} currentRidesList={{ carts: m_Data.current.carts || Data.Carts, horses: m_Data.current.horses || Data.Horses }} /> ||
        route === "/buycart" && <BuyRideMenu rideType={RideTypes.cart} currentRidesList={{ carts: m_Data.current.carts || Data.Carts, horses: m_Data.current.horses || Data.Horses }} /> ||
        route.startsWith("/buycomps") && <BuyCompsMenu Comps={m_Data.Complements} buyable={true} horseId={Number(route.split("?")[1])} /> ||
        route.startsWith("/changecomps") && <BuyCompsMenu Comps={m_Data.player.availableComps} buyable={false} horseId={Number(route.split("?")[1])} /> ||
        route === "/myrides" && <MyRidesMenu Data={m_Data.player} /> ||
        route.startsWith("/transfer") && <TransferModal
          rideId={Number(route.split("?")[1])}
          rideName={m_Data.player.rides.find(r => r.id == Number(route.split("?")[1])).name}
          characters={m_Data.characters}
        /> ||
        route.startsWith("/recieve") && m_Data.player.transferedRides && <TransferRecieve
          rideId={Number(m_Data.player.transferedRides[0].id)}
          rideName={m_Data.player.transferedRides[0].name}
          characters={m_Data.characters}
          giverId={m_Data.player.transferedRides[0].owner}
          price={m_Data.player.transferedRides[0].price}
        /> ||
        route === "/exit" && exit()
      }
    </RouteCtx.Provider>
  )

}

export default App
export { Data, RouteCtx }