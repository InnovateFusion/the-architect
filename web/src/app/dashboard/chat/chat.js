import Image from "next/image";

export default function Chat() {
  return (
    <>
      <div className="border  bg-slate-300 overflow-y-auto h-5/6">
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

      <div>
        <div className="flex items-center border-b border-gray-500 py-2">
          <input
            type="text"
            placeholder="Type a message..."
            className="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
          />
          <button
            type="submit"
            className="flex-shrink-0 bg-blue-500 hover:bg-blue-700 border-blue-500 hover:border-blue-700 text-sm border-4 text-white py-1 px-2 rounded"
          >
            Send
          </button>
        </div>
      </div>
    </>
  );
}
