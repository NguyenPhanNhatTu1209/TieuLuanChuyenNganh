import io, { Socket } from "socket.io-client";

class SocketService {
  public socket: any | null = null;

  public connect(url: string): Promise<any> {
    return new Promise((rs, rj) => {
      this.socket = io(url, {
        transports: ["websocket", "polling"],
        secure: true,
        reconnection: true,
        rejectUnauthorized: false,
      });

      console.log(this.socket);

      if (!this.socket) return rj();

      this.socket.on("connect", () => {
        rs(this.socket as any);
      });

      this.socket.on("connect_error", (err: any) => {
        console.log("Connection error: ", err);
        rj(err);
      });
    });
  }

  public disconnectSocket = () => {
    this.socket.disconnect();
  };
}

export default new SocketService();
