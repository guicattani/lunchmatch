import { Tab, Tabs, TabList, TabPanel } from "react-tabs";
import "react-tabs/style/react-tabs.css";

import EmployeesTable from "./EmployeesTable";
import DepartmentsTable from "./DepartmentsTable";
import RoundsTable from "./RoundsTable";

/**
 * LunchMatcherTabs is the component that holds all the tables and organizes
 * them in tabs
 */
export default function LunchMatcherTabs() {
  return (
    <div>
      <Tabs>
        <TabList>
          <Tab>Employees</Tab>
          <Tab>Departments</Tab>
          <Tab>Rounds</Tab>
        </TabList>

        <TabPanel>
          <EmployeesTable />
        </TabPanel>

        <TabPanel>
          <DepartmentsTable />
        </TabPanel>

        <TabPanel>
          <RoundsTable />
        </TabPanel>
      </Tabs>
    </div>
  );
}
