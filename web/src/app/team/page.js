"use client";
import { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import useTeams from "@/hooks/useTeam";
import { Capitalize } from "@/utils/utils";
import { GitBranchPlus, Link as Link2 } from "lucide-react";
import CreateTeam from "./createTeam";
import { toast } from "react-toastify";
import { useTeamStore } from "@/store/store";
import { useRouter } from "next/navigation";
import { Button } from "@tremor/react";

export default function Test() {
  const { data: teams, isLoading, isError, error } = useTeams();
  let [isOpen, setIsOpen] = useState(false);
  const currentTeam = useTeamStore((state) => state.team);
  const setTeam = useTeamStore((state) => state.setTeam);
  const router = useRouter();

  function closeModal() {
    setIsOpen(false);
  }

  function openModal() {
    setIsOpen(true);
  }

  if (isError) {
    if (error?.response?.status == 401) {
      router.push("/auth/signin");
      toast.error("Authentication failed. Please login again.");
    }
    toast.error(error.message);
    return <div>{error.message}</div>;
  }

  return (
    <>
      <div>
        <div className="box p-6 shadow w-full sticky top-0 z-[5000] px-2 py-2 bg-transparent gap-2 backdrop-blur-sm flex flex-row justify-end md:justify-end items-start mx-auto ">
          <Button
            variant="secondary"
            className="bg-green-500 rounded-xl hover:bg-green-600"
            icon={GitBranchPlus}
            onClick={openModal}
          >
            <div className="hidden md:block">Create Team</div>
          </Button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-4 p-4">
          {isLoading && <div>Loading...</div>}
          {isError && <div>{error.message}</div>}
          {teams?.map((team, i) => (
            <div className="w-full  lg:flex" key={i}>
              <Image
                className="h-48 lg:h-48 lg:w-48 flex-none bg-cover rounded-tl-lg lg:rounded-t-none lg:rounded-l text-center overflow-hidden border border-r-0 dark:border-gray-500 border-gray-400"
                src={team.image || "/housteam.jpg"}
                width={512}
                height={512}
                alt={team.first_name}
                priority
              />
              <div className="border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white dark:bg-gray-800 shadow  rounded-b lg:rounded-b-none lg:rounded-r p-2 flex flex-col justify-between leading-normal dark:border-gray-500 w-full">
                <div className="mb-8">
                  <p className="text-sm text-gray-600 dark:text-gray-300 flex items-center">
                    <svg
                      className="fill-current  w-3 h-3 mr-2"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 20 20"
                    >
                      <path d="M4 8V6a6 6 0 1 1 12 0v2h1a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-8c0-1.1.9-2 2-2h1zm5 6.73V17h2v-2.27a2 2 0 1 0-2 0zM7 6v2h6V6a3 3 0 0 0-6 0z" />
                    </svg>
                    Newly Created
                  </p>
                  <div className="text-gray-900 dark:text-white font-bold text-xl mb-2">
                    <Link
                      onClick={(e) => setTeam(team)}
                      href={`/team/${team.id}`}
                    >
                      {Capitalize(team.title)}
                    </Link>
                  </div>
                  <p className="text-gray-700 dark:text-gray-400 text-base">
                    {team.description}
                  </p>
                </div>
                <div className="flex justify-between">
                  <Link
                    className="flex w-fit items-center space-x-2"
                    href={`/team/profile/${team.creator_id}`}
                  >
                    <Image
                      className="p-1 aspect-square rounded-full"
                      src={team.creator_image}
                      width={40}
                      height={40}
                      alt={team.first_name}
                      priority
                    />
                    <h2 className="font-bold cursor-pointer">
                      {Capitalize(team.first_name)} {Capitalize(team.last_name)}
                    </h2>
                  </Link>
                  <Link
                    onClick={(e) => setTeam(team)}
                    href={`/team/chat/${team.id}`}
                  >
                    <Link2 />
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
      <CreateTeam closeModal={closeModal} isOpen={isOpen} />
    </>
  );
}
