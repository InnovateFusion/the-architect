"use client";
import { Dialog, Transition } from "@headlessui/react";
import { Fragment, useState } from "react";
import TeamAPIClient from "@/store/apiClientTeam";
import { TextInput, Textarea } from "@tremor/react";
export default function CreateTeam({ closeModal, isOpen }) {
  const [title, setTitle] = useState("Innovate Fusion");
  const [description, setdescription] = useState(
    "We are here to create with Magit and Innovation."
  );
  const [image, setimage] = useState(
    "https://res.cloudinary.com/dtghsmx0s/image/upload/v1699557278/zc85wpbwdquldsdkivqw.png"
  );
  const [user_ids, setuser_ids] = useState([
    "35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a",
  ]);

  const apiClient = new TeamAPIClient();
  const handleCreate = async () => {
    const x = await apiClient.createTeam({
      title,
      description,
      image,
      user_ids,
    });
    console.log(x);
    closeModal();
  };
  return (
    <Transition appear show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-10" onClose={closeModal}>
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-black/25" />
        </Transition.Child>

        <div className="fixed inset-0 overflow-y-auto">
          <div className="flex min-h-full items-center justify-center p-4 text-center">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <Dialog.Panel className="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">
                <Dialog.Title
                  as="h3"
                  className="text-lg font-medium leading-6 text-gray-900"
                >
                  Create New Team
                </Dialog.Title>
                <div className="flex flex-col mt-2 gap-4">
                  <TextInput placeholder="Team Name" />
                  <Textarea placeholder="Team Description" />
                </div>

                <div className="mt-4 text-end">
                  <button
                    type="button"
                    className="inline-flex justify-center rounded-md border border-transparent bg-blue-100 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2"
                    onClick={handleCreate}
                  >
                    Create Team
                  </button>
                </div>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
}
