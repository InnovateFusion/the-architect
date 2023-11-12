"use client";
import { Capitalize } from "@/utils/utils";
import Link from "next/link";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { toast } from "react-toastify";
import { useTeam, useTeamMembers, useAllMembers } from "@/hooks/useTeam";
import { Card, Title, Text } from "@tremor/react";
import Search from "./search";
import UsersTable from "./table";
import { fDate } from "@/utils/formatTime";
import { Trash } from "lucide-react";
import TeamAPIClient from "@/store/apiClientTeam";

export default function Team({ searchParams, params: { id } }) {
  const router = useRouter();
  const search = searchParams.q ?? "";

  const {
    data: team,
    isLoading: teamLoading,
    isError: teamError,
  } = useTeam(id);

  const {
    data: members,
    isLoading: membersLoading,
    isError: membersError,
  } = useTeamMembers(id);

  const {
    data: users,
    isLoading: usersLoading,
    isError: usersError,
  } = useAllMembers();

  const handleDelete = () => {
    const apiClient = new TeamAPIClient();
    apiCient.deleteTeam();
  };

  if (teamLoading || usersLoading || membersLoading) {
    return <div>Loading..</div>;
  }

  if (teamError) {
    router.push("/team");
    return <div>Something went wrong.</div>;
  }

  if (membersError || usersError) {
    return <div>Something went wrong.</div>;
  }

  return (
    <main className="p-4 mx-auto max-w-7xl">
      <div className="md:flex-1 pt-4 flex gap-2  m-4 ">
        <div className="rounded-lg mb-4 ">
          <Image
            className="aspect-square rounded-full hover:cursor-pointer "
            src={team.image || "/house.jpg"}
            alt={team.first_name}
            width={200}
            height={200}
            priority
          />
        </div>
        <div className="rounded-lg m-4 align-center justify-center">
          <div className="flex flex-col space-r-2 ">
            <h4 className="text-3xl font-bold cursor-pointer">
              {Capitalize(team.title)}
            </h4>
          </div>
          {/* <div className="flex pt-4 space-x-2">
              <span>Email: </span>
              <h2 className="font-bold text-gray-800 dark:text-white mb-2">
                {team.title}
              </h2>
            </div> */}
          <div className="flex pt-4 space-x-2 items-center justify-center">
            Created by
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
              <h2 className="font-bold cursor-pointer pr-2">
                {Capitalize(team.first_name)} {Capitalize(team.last_name)}
              </h2>
            </Link>{" "}
            on {fDate(team.create_at)}
          </div>

          <div className="flex space-x-2 pt-4 gap-5 ">
            <div className="flex flex-col items-center">
              <span className="text-2xl"> {members.length || 0} </span>
              <span className="font-bold"> Members </span>
            </div>
            <div className="flex flex-col items-center">
              <span className="text-2xl"> {members.length || 0} </span>
              <span className="font-bold"> Posts </span>
            </div>
            <div className="flex flex-col items-center">
              <span className="text-2xl"> {users.length || 0} </span>
              <span className="font-bold"> Users </span>
            </div>
          </div>
        </div>
        <div className="rounded-lg m-4 flex flex-col flex-end">
          <button
            className="flex w-9 h-9 flex-end justify-end items-end cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2 hover:bg-red-600"
            onClick={handleDelete}
          >
            <Trash />
          </button>
          Team Description:
          <h2 className="font-bold text-gray-800 dark:text-white mb-2">
            {Capitalize(team.description)}
          </h2>
        </div>
      </div>
      <Title>Team Members</Title>
      <Text>This is list of users in your team.</Text>
      <div className="w-full flex gap-5">
        <Card className="mt-6 rounded-lg w-full md:w-1/2 z-1">
          <UsersTable users={members} x={1} />
        </Card>
        <Search users={users} />
      </div>
    </main>
  );
}
