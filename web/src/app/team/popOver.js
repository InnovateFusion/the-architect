import { Popover, Transition } from "@headlessui/react";
import { ChevronDown, PackageOpen, Terminal } from "lucide-react";
import { Fragment } from "react";
import useTeams from "../../hooks/useTeam";
import { useTeamStore } from "@/store/store";
import Link from "next/link";

export default function PopOver() {
  const { data: teams, isLoading, isError, error } = useTeams();

  const currentTeam = useTeamStore((state) => state.team);
  const setTeam = useTeamStore((state) => state.setTeam);
  return (
    <div className="top-4 w-full z-50">
      <Popover className="relative">
        {({ open }) => (
          <>
            <Popover.Button
              className={`
                ${
                  open
                    ? "dark:text-black text-gray-700 bg-green-500"
                    : "dark:text-black/90 text-gray-/90 bg-green-400"
                }
                group inline-flex items-center rounded-md bg-green-400 px-3 py-2 text-base font-medium hover:bg-green-500 focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75 w-full`}
            >
              <span className="hidden md:block max-w-sm overflow-hidden">
                {currentTeam ? currentTeam.title : "Select Team"}
              </span>
              <ChevronDown
                className={`${open ? "text-gray-700" : "text-gray-700/70"}
                  ml-2 h-5 w-5 transition duration-150 ease-in-out group-hover:text-gray-700/80`}
                aria-hidden="true"
              />
            </Popover.Button>
            <Transition
              as={Fragment}
              enter="transition ease-out duration-200"
              enterFrom="opacity-0 translate-y-1"
              enterTo="opacity-100 translate-y-0"
              leave="transition ease-in duration-150"
              leaveFrom="opacity-100 translate-y-0"
              leaveTo="opacity-0 translate-y-1"
            >
              <Popover.Panel className="absolute left-24 z-50 mt-3 w-[200px] -translate-x-1/2 transform px-4 sm:px-0 ">
                <div className="left-100 overflow-hidden rounded-lg shadow-lg ring-1 ring-black/5 z-50">
                  <div className="overflow-y-auto max-h-56 relative grid gap-8 bg-white p-7 lg:grid-cols-1 z-50">
                    {isLoading ? (
                      <div> Loading...</div>
                    ) : (
                      teams &&
                      teams.map((team) => (
                        <Link
                          key={team.id}
                          href={`/team/${team.id}`}
                          onClick={(e) => setTeam(team)}
                          className="-m-3 flex items-center rounded-lg p-2 transition duration-150 ease-in-out hover:bg-gray-50 focus:outline-none focus-visible:ring focus-visible:ring-orange-500/50"
                        >
                          <div className="flex h-6 w-6 shrink-0 items-center justify-center text-white sm:h-7 sm:w-7">
                            <IconOne />
                          </div>
                          <div className="ml-4 whitespace-nowrap overflow-hidden">
                            <p className="text-sm font-medium text-gray-900 flex flex-nowrap overflow-hidden">
                              {team.title}
                            </p>
                            <p className="text-sm text-gray-500 hidden md:block">
                              {team.description}
                            </p>
                          </div>
                        </Link>
                      ))
                    )}
                  </div>
                  <div className="bg-gray-50 p-4">
                    <a
                      href="##"
                      className="flow-root rounded-md px-2 py-2 transition duration-150 ease-in-out hover:bg-gray-100 focus:outline-none focus-visible:ring focus-visible:ring-orange-500/50"
                    >
                      <span className="flex items-center">
                        {/* <span className="text-sm font-medium text-gray-900">
                          Create Team
                        </span> */}
                      </span>
                      <span className="text-sm text-gray-500 hidden md:block">
                        Please Select Team
                      </span>
                    </a>
                  </div>
                </div>
              </Popover.Panel>
            </Transition>
          </>
        )}
      </Popover>
    </div>
  );
}

function IconOne() {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="32"
      height="32"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
      class="lucide lucide-users-2"
    >
      <path d="M14 19a6 6 0 0 0-12 0" stroke="#FB923C" />
      <circle cx="8" cy="9" r="4" stroke="#FB923C" />
      <path d="M22 19a6 6 0 0 0-6-6 4 4 0 1 0 0-8" stroke="#FB923C" />
    </svg>
  );
}

function IconTwo() {
  return (
    <svg
      width="48"
      height="48"
      viewBox="0 0 48 48"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <rect width="48" height="48" rx="8" fill="#FFEDD5" />
      <path
        d="M28.0413 20L23.9998 13L19.9585 20M32.0828 27.0001L36.1242 34H28.0415M19.9585 34H11.8755L15.9171 27"
        stroke="#FB923C"
        strokeWidth="2"
      />
      <path
        fillRule="evenodd"
        clipRule="evenodd"
        d="M18.804 30H29.1963L24.0001 21L18.804 30Z"
        stroke="#FDBA74"
        strokeWidth="2"
      />
    </svg>
  );
}

function IconThree() {
  return (
    <svg
      width="48"
      height="48"
      viewBox="0 0 48 48"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <rect width="48" height="48" rx="8" fill="#FFEDD5" />
      <rect x="13" y="32" width="2" height="4" fill="#FDBA74" />
      <rect x="17" y="28" width="2" height="8" fill="#FDBA74" />
      <rect x="21" y="24" width="2" height="12" fill="#FDBA74" />
      <rect x="25" y="20" width="2" height="16" fill="#FDBA74" />
      <rect x="29" y="16" width="2" height="20" fill="#FB923C" />
      <rect x="33" y="12" width="2" height="24" fill="#FB923C" />
    </svg>
  );
}
