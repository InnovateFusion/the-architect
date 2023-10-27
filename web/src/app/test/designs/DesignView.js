const Modal = ({ open, handleOpen, size, children }) => {
  return (
    <div
      className={`fixed z-20 inset-0 w-full h-full flex items-center justify-center ${
        open ? "block" : "hidden"
      }`}
    >
      <div
        className="modal-overlay absolute inset-0 bg-black dark:bg-white opacity-50"
        onClick={handleOpen}
      />

      <div
        className={`modal-container bg-white dark:bg-gray-600 w-${size || "11/12"} md:max-w-${
          size || "5xl"
        } mx-auto rounded shadow-lg z-50 overflow-y-auto`}
      >
        <div className="modal-content py-4 text-left px-6">{children}</div>
      </div>
    </div>
  );
};

export default Modal;
