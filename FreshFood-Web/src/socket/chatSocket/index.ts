import { Socket } from "socket.io-client";
import { EVENTSOCKET } from "../event.socket";

class ChatSocket {
  public async sendMessageCSS(
    socket: any,
    payload: {
      message: string;
    }
  ) {
    socket.emit(EVENTSOCKET.SEND_MESSAGE_CSS, payload);
  }

  public async sendMessageSSC(socket: any, listener: (data: any) => void) {
    socket.on(EVENTSOCKET.SEND_MESSAGE_SSC, listener);
  }

  public async joinRoomCSS(
    socket: any,
    payload: {
      idRoom: string;
    }
  ) {
    socket.emit(EVENTSOCKET.JOIN_ROOM_CSS, { idUser: payload.idRoom });
  }

  public async leaveRoomCSS(
    socket: any,
    payload: {
      idRoom: string;
    }
  ) {
    socket.emit(EVENTSOCKET.LEAVE_ROOM_CSS, { idUser: payload.idRoom });
  }
}

export default new ChatSocket();
