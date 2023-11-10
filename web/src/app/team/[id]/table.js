import { Capitalize } from "@/utils/utils";
import {
  Select,
  Table,
  TableHead,
  TableRow,
  TableHeaderCell,
  TableBody,
  TableCell,
  Text,
} from "@tremor/react";

export default function UsersTable({ users, x }) {
  return (
    <Table className="z-1">
      <TableHead>
        <TableRow>
          {!x && <TableHeaderCell> </TableHeaderCell>}
          <TableHeaderCell>First Name</TableHeaderCell>
          <TableHeaderCell>Last Name</TableHeaderCell>
          <TableHeaderCell>Email</TableHeaderCell>
          {x && <TableHeaderCell>Country</TableHeaderCell>}
        </TableRow>
      </TableHead>
      <TableBody>
        {users.map((user) => (
          <TableRow key={user.id}>
            {!x && <TableCell><input type="checkbox" ></input></TableCell>}
            <TableCell>{Capitalize(user.firstName)}</TableCell>
            <TableCell>{Capitalize(user.lastName)}</TableCell>
            <TableCell>
              <Text>{user.email}</Text>
            </TableCell>
            {x && (
              <TableCell>
                <Text>{user.country}</Text>
              </TableCell>
            )}
          </TableRow>
        ))}
      </TableBody>
    </Table>
  );
}