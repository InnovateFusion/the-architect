import Image from "next/image";

export default function Chat() {
  return (
    <div className="border">
      <div className="chat chat-start">
        <div className="chat-image avatar">
          <div className="w-12 rounded-full p-3">
            <Image src="/logo.svg" width={200} alt="" height={200} />
          </div>
        </div>
        <div className="chat-bubble">
          <Image src="/logo.svg" width={200} alt="" height={200} />
        </div>
      </div>
      <div className="chat chat-end">
        <div className="chat-image avatar">
          <div className="w-12 rounded-full">
            <Image src="/if.png" width={200} alt="" height={200} />
          </div>
        </div>
        <div className="chat-bubble">Make it more lighter</div>
      </div>
      <div className="chat chat-start">
        <div className="chat-image avatar">
          <div className="w-12 rounded-full p-3">
            <Image src="/logo.svg" width={200} alt="" height={200} />
          </div>
        </div>
        <div className="chat-bubble">
          <Image src="/logo.svg" width={200} alt="" height={200} />
        </div>
      </div>
      <div className="chat chat-end">
        <div className="chat-image avatar">
          <div className="w-12 rounded-full">
            <Image src="/if.png" width={200} alt="" height={200} />
          </div>
        </div>
        <div className="chat-bubble">Make it more lighter</div>
      </div>
      <div className="chat chat-start">
        <div className="chat-image avatar">
          <div className="w-12 rounded-full p-3">
            <Image src="/logo.svg" width={200} alt="" height={200} />
          </div>
        </div>
        <div className="chat-bubble">
          <Image src="/logo.svg" width={200} alt="" height={200} />
        </div>
      </div>
      <div className="chat chat-end">
        <div className="chat-image avatar">
          <div className="w-12 rounded-full">
            <Image src="/if.png" width={200} alt="" height={200} />
          </div>
        </div>
        <div className="chat-bubble">Make it more lighter</div>
      </div>
    </div>
  );
}
