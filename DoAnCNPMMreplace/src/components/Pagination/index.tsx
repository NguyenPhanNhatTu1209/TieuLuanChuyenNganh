import React, { useRef, useState } from "react";

const Pagination = (props: { page?: number; handleChangePage?: any }) => {
  const { page, handleChangePage } = props;

  const [pagination, setPagination] = useState(1);

  const handleChange = (thisPage: number) => {
    if (thisPage === pagination) return;
    setPagination(thisPage);
    document
      .getElementById(`page-item-${pagination}`)
      ?.classList.remove("active");
    document.getElementById(`page-item-${thisPage}`)?.classList.add("active");
    handleChangePage(thisPage);
  };

  React.useEffect(() => {
    document.getElementById(`page-item-${pagination}`)?.classList.add("active");
  }, []);

  return (
    <div className="row mt-5">
      <div className="col text-center">
        <div className="block-27">
          <ul className="pagination-list">
            {[...Array(page)].map((e: any, i: number) => (
              <li className="page-item" id={`page-item-${i + 1}`} key={i}>
                <button
                  className="page-link"
                  onClick={() => handleChange(i + 1)}
                >
                  {i + 1}
                </button>
              </li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  );
};

export default Pagination;
