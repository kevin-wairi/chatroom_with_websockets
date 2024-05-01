import React from "react";
import ActionCable from "actioncable";

const CableContext = React.createContext();

function CableProvider({ children }) {

    // const actionCableUrl = process.env.NODE_ENV === 'production' ? 'wss://<your-deployed-app-domain>.com/cable' : 'ws://localhost:3000/cable'
    const actionCableUrl = 'ws://127.0.0.1:3000/cable'

    const CableApp = {}
    CableApp.cable = ActionCable.createConsumer(actionCableUrl)

    return <CableContext.Provider value={CableApp.cable}>{children}</CableContext.Provider>;
}

export { CableContext, CableProvider };