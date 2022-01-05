import React from "react";
import Select from "react-select";

// const options = [
//   { value: "chocolate", label: "28 Luu Chi Hieu, Phuoc Hung, TP Ba Ria" },
//   {
//     value: "strawberry",
//     label: "Opal Garden, Duong so 20, Phuong Hiep Binh Chanh, Quan Thu Duc",
//   },
// ];

export const SelectCustom = (props: { options?: any; handleChange?: any }) => {
  const { options, handleChange } = props;

  return (
    <>
      <Select
        onChange={handleChange}
        className="selectOption"
        options={options.map((item: any) => {
          return {
            value: item._id,
            label: `${item.address}, ${item.district}, ${item.province} `,
          };
        })}
      />
    </>
  );
};
