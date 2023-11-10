import { useQuery } from "@tanstack/react-query";
import TeamAPIClient from "@/store/apiClientTeam";
import { useTeamStore } from "@/store/store";

const useTeams = () => {
  const teams = useTeamStore((state) => state.teams);
  const apiClient = new TeamAPIClient();
  return useQuery({
    queryKey: ["teams", teams],
    queryFn: () => apiClient.myTeams(),
  });
};

export const useTeam = (id) => {
  const apiClient = new TeamAPIClient();
  return useQuery({
    queryKey: [`team${id}`],
    queryFn: () => apiClient.getTeam(id),
  });
};

export const useTeamMembers = (id) => {
  const apiClient = new TeamAPIClient();
  return useQuery({
    queryKey: [`team${id}members`],
    queryFn: () => apiClient.getMembers(id),
  });
};

export const useAllMembers = () => {
  const apiClient = new TeamAPIClient();
  return useQuery({
    queryKey: [`allusers`],
    queryFn: () => apiClient.getAllMembers(),
  });
};

export const useUser = (id) => {
  const apiClient = new TeamAPIClient();
  return useQuery({
    queryKey: [`user`],
    queryFn: () => apiClient.getUser(id),
  });
};
export const useMessages = (id) => {
  const apiClient = new TeamAPIClient();
  return useQuery({
    queryKey: [`messages`],
    queryFn: () => apiClient.getMessages(id),
  });
};
export default useTeams;
