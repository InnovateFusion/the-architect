import { useTeamStore } from "@/store/store";
const currentTeam = useTeamStore((state) => state.team);
