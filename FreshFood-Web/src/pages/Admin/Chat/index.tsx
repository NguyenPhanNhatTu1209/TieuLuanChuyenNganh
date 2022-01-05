import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { useDispatch, useSelector } from "react-redux";
import { selectCurrentUser } from "../../../features/auths/slice/selector";
import { getCurrentUserAsync } from "../../../features/auths/slice/thunk";
import { addMessage, revMessage } from "../../../features/chat/slice";
import {
  selectAllMessage,
  selectAllRoom,
} from "../../../features/chat/slice/selector";
import {
  getAllMessageAsync,
  getAllRoomAsync,
} from "../../../features/chat/slice/thunk";
import baseSocket from "../../../socket/baseSocket";
import {
  default as ChatSocket,
  default as chatSocket,
} from "../../../socket/chatSocket";
import "./style.scss";

interface ChatProps {}

const AdminChat = (props: ChatProps) => {
  const [avatar, setAvatar] = useState<any>("");
  const [name, setName] = useState("");
  const [historyRoom, setHistoryRoom] = useState("");

  const dispatch = useDispatch();
  const chatRoom = useSelector(selectAllRoom);
  const message = useSelector(selectAllMessage);
  const curUser = useSelector(selectCurrentUser);

  const connectSocket = async (url: string) => {
    const socket = await baseSocket.connect(url).catch((err) => {
      console.log("Error: ", err);
    });
  };

  const token = localStorage.getItem("token");
  React.useEffect(() => {
    if (token) {
      // console.log(`123`, token);
      const urlSocket = `https://befreshfood.tk/?token=Bearer ${token}`;
      connectSocket(urlSocket);
    }
  }, [token]);

  React.useEffect(() => {
    onMessage();

    dispatch(getCurrentUserAsync());
    dispatch(getAllMessageAsync({ skip: 0, limit: 15, idRoom: curUser._id }));
    if (curUser.role === 1) {
      dispatch(getAllRoomAsync());
    } else if (curUser.role === 0) {
      chatSocket.joinRoomCSS(baseSocket.socket, { idRoom: curUser._id });
      setHistoryRoom(curUser._id);
    }

    return () => {
      baseSocket.disconnectSocket();
      dispatch(revMessage());
    };
  }, []);

  const handleClick = (roomId: string, avatar: string, name: string) => {
    dispatch(
      getAllMessageAsync({
        idRoom: roomId,
        skip: 1,
        limit: 15,
      })
    );
    if (baseSocket.socket) {
      if (historyRoom != "") {
        chatSocket.leaveRoomCSS(baseSocket.socket, { idRoom: historyRoom });
      }
      chatSocket.joinRoomCSS(baseSocket.socket, { idRoom: roomId });

      setHistoryRoom(roomId);
    }
    setAvatar(avatar);
    setName(name);
  };

  const { reset, handleSubmit, register } = useForm();

  const submit = (data: any, e: any) => {
    e.preventDefault();
    ChatSocket.sendMessageCSS(baseSocket.socket, { message: data.message });

    reset();
  };

  const handleLeaveRoom = () => {
    baseSocket.disconnectSocket();
  };

  const onMessage = () => {
    if (baseSocket.socket) {
      chatSocket.sendMessageSSC(baseSocket.socket, (data: any) => {
        dispatch(addMessage(data));
      });
    }
  };
  window.onhashchange = () => {
    baseSocket.disconnectSocket();
  };

  return (
    <div>
      <div className="container">
        <div className="Chat ">
          <div className="row no-gutters">
            <div className="col-md-4 border-right">
              <div className="settings-tray">
                <img
                  className="profile-image"
                  src={curUser.avatar}
                  alt="Profile img"
                />
                <span className="settings-tray--right">
                  <i onClick={handleLeaveRoom} className="material-icons">
                    cached
                  </i>
                  <i className="material-icons">message</i>
                  <i className="material-icons">menu</i>
                </span>
              </div>
              <div className="search-box">
                <div className="input-wrapper">
                  <i className="material-icons">search</i>
                  <input placeholder="Search here" type="text" />
                </div>
              </div>
              {(chatRoom || []).map((item: any, i: number) => (
                <div
                  className="friend-drawer friend-drawer--onhover"
                  key={i}
                  onClick={() =>
                    handleClick(item.idRoom, item.avatar, item.name)
                  }
                >
                  <img className="profile-image" src={item.avatar} alt="" />
                  <div className="text">
                    <h6>{item.name}</h6>
                    <p className="text-muted">{item.message}</p>
                  </div>
                  <span className="time text-muted small">13:21</span>
                </div>
              ))}
            </div>
            <div
              className="col-md-8"
              style={{
                height: "80vh",
                overflowY: "scroll",
                overflowX: "hidden",
              }}
            >
              <div className="settings-tray">
                <div className="friend-drawer no-gutters friend-drawer--grey">
                  {avatar == "" ? (
                    ``
                  ) : (
                    <img className="profile-image" src={avatar} alt="" />
                  )}

                  <div className="text">
                    <h6>{name == "" ? `` : name}</h6>
                    {/* <p className="text-muted">
                      Layin' down the law since like before Christ...
                    </p> */}
                  </div>
                  <span className="settings-tray--right">
                    <i className="material-icons">cached</i>
                    <i className="material-icons">message</i>
                    <i className="material-icons">menu</i>
                  </span>
                </div>
              </div>
              <div className="chat-panel" style={{ height: "100%" }}>
                {[...message].reverse().map((item: any, i: number) => (
                  <>
                    {curUser._id !== item.creatorUser ? (
                      <div className="row no-gutters" key={i}>
                        <div className="col-md-3">
                          <div className="chat-bubble chat-bubble--left">
                            {item.message}
                          </div>
                        </div>
                      </div>
                    ) : (
                      <div className="row no-gutters" key={i}>
                        <div className="col-md-3 offset-md-9">
                          <div className="chat-bubble chat-bubble--right">
                            {item.message}
                          </div>
                        </div>
                      </div>
                    )}
                  </>
                ))}
                <form onSubmit={handleSubmit(submit)}>
                  <div className="row">
                    <div className="col-12">
                      <div className="chat-box-tray">
                        <i className="material-icons">
                          sentiment_very_satisfied
                        </i>
                        <input
                          {...register("message")}
                          type="text"
                          placeholder="Type your message here..."
                        />
                        <i className="material-icons">mic</i>
                        <button type="submit" style={{ border: "none" }}>
                          <i className="material-icons">send</i>
                        </button>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdminChat;
