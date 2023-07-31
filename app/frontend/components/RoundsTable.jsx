import { useState, useMemo, useEffect } from "react";
import { useForm } from "react-hook-form";

import Modal from "react-modal";
import { MaterialReactTable } from "material-react-table";

import { Favorite } from "@mui/icons-material/";
import { IconButton, Tooltip } from "@mui/material";
import { AddBox, Save, Close } from "@mui/icons-material/";

/**
 * RoundsTable is the component the Table and the Start Match action
 * for the Round model
 *
 * It starts by fetching rounds from `/api/v1/rounds`
 */
export default function RoundsTable() {
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [tableLoading, setTableLoading] = useState(true);
  const [rounds, setRounds] = useState(false);

  useEffect(() => {
    fetch("/api/v1/rounds")
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        setRounds(data);
        setTableLoading(false);
      });
  }, []);

  const customStyles = {
    content: {
      top: "50%",
      left: "50%",
      right: "auto",
      bottom: "auto",
      marginRight: "-50%",
      transform: "translate(-50%, -50%)",
    },
  };

  const openModal = () => {
    setModalIsOpen(true);
  };

  const closeModal = () => {
    setModalIsOpen(false);
  };

  const onSubmit = (e) => {
    createRound({
      name: e.Name,
    });
    closeModal();
  };

  const createRound = (attributes) => {
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(attributes),
    };
    fetch("/api/v1/rounds", requestOptions)
      .then((response) => response.json())
      .then((data) => {
        setRounds([...rounds, ...data]);
      });
  };

  //should be memoized or stable
  const columns = useMemo(
    () => [
      {
        accessorKey: "group.round.name",
        header: "Name",
        size: 100,
      },
      {
        accessorKey: "leader",
        header: "Leader?",
        size: 100,
        Cell: ({ cell }) => (cell.getValue() ? "True" : "False"),
      },
      {
        accessorKey: "employee.name",
        header: "Employee",
        size: 100,
      },
      {
        accessorKey: "employee.department.name",
        header: "Deparment",
        size: 100,
      },
      {
        accessorKey: "group.id",
        header: "Group ID",
        size: 90,
      },
    ],
    []
  );

  let formFields = {};
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  return (
    <div>
      <div>
        <Modal
          isOpen={modalIsOpen}
          onRequestClose={closeModal}
          style={customStyles}
          contentLabel="Start new Round"
        >
          <div className="flex pb-4">
            <h2 className="flex-1">Add New Round</h2>
            <button onClick={closeModal}>
              <Close />
            </button>
          </div>

          <form className="w-full max-w-sm" onSubmit={handleSubmit(onSubmit)}>
            <div className="md:flex md:items-center mb-6">
              <div className="md:w-1/3">
                <label> Name</label>
              </div>
              <div className="md:w-2/3">
                <input
                  className="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500"
                  ref={(input) => (formFields.Name = input)}
                  id="Name"
                  type="text"
                  placeholder="New round name"
                  required
                  {...register("Name", { required: true })}
                />
              </div>
            </div>
            <div className="md:flex md:items-center">
              <div className="md:w-1/3"></div>
              <div className="md:w-2/3 flex">
                <button
                  className="shadow bg-blue-500 hover:bg-blue-400 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded"
                  type="submit"
                >
                  <div className="flex">
                    <Favorite />
                    <p>Create new round</p>
                  </div>
                </button>
              </div>
            </div>
          </form>
        </Modal>
      </div>
      <MaterialReactTable
        layoutMode="grid"
        columns={columns}
        data={rounds}
        enableTopToolbar={!modalIsOpen}
        enableBottomToolbar={!modalIsOpen}
        state={{ isLoading: tableLoading }}
        muiTableContainerProps={{
          sx: {
            minWidth: "1000px",
          },
        }}
        enableGrouping
        initialState={{
          grouping: ["group.round.name", "group.id"],
          expanded: true,
        }}
        renderTopToolbarCustomActions={() => {
          return (
            <div>
              <Tooltip arrow title="Start new round">
                <IconButton onClick={openModal}>
                  <Favorite />
                </IconButton>
              </Tooltip>
            </div>
          );
        }}
      />
    </div>
  );
}
