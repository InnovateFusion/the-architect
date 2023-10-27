import Image from "next/image";
export default function Test() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-4">
      {[1, 2, 3, 4, 5, 6].map((e, i) => (
        <div className="max-w-sm w-full lg:max-w-full lg:flex" key={i}>
          <Image
            className="h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-tl-lg lg:rounded-t-none lg:rounded-l text-center overflow-hidden"
            src="/house.jpg"
            width={512}
            height={512}
            alt="Avatar of Jonathan Reinink"
          />
          <div className="border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal">
            <div className="mb-8">
              <p className="text-sm text-gray-600 flex items-center">
                <svg
                  className="fill-current text-gray-500 w-3 h-3 mr-2"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                >
                  <path d="M4 8V6a6 6 0 1 1 12 0v2h1a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-8c0-1.1.9-2 2-2h1zm5 6.73V17h2v-2.27a2 2 0 1 0-2 0zM7 6v2h6V6a3 3 0 0 0-6 0z" />
                </svg>
                New
              </p>
              <div className="text-gray-900 font-bold text-xl mb-2">
                Can you be better developer?
              </div>
              <p className="text-gray-700 text-base">
                Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                Voluptatibus quia, nulla!
              </p>
            </div>
            <div className="flex items-center">
              <Image
                className="w-10 h-10 rounded-full mr-4"
                src="/house.jpg"
                width={512}
                height={512}
                alt="Avatar of Jonathan Reinink"
              />
              <div className="text-sm">
                <p className="text-gray-900 leading-none">Jonathan Reinink</p>
                <p className="text-gray-600">Aug 18</p>
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
