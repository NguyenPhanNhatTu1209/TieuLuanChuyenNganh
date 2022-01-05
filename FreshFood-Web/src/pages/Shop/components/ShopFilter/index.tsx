import React from "react";

interface Props {
  groupProducts: Array<object>;
  changeCategory: any;
}

const ShopFilter = (props: Props) => {
  const [category, setCategory] = React.useState(0);

  const handleClick = (key: string, index: number) => {
    if (index === category) return;
    setCategory(index);
    document.getElementById(`category-${category}`)?.classList.remove("active");
    document.getElementById(`category-${index}`)?.classList.add("active");
    props.changeCategory(key);
  };

  React.useEffect(() => {
    document.getElementById(`category-${category}`)?.classList.add("active");
  }, []);

  return (
    <div className="row justify-content-center">
      <div className="col-md-10 mb-5 text-center">
        <ul className="product-category">
          <li>
            <a
              style={{ cursor: "pointer" }}
              className="category"
              id={`category-0`}
              onClick={() => handleClick("", 0)}
            >
              All
            </a>
          </li>
          {props.groupProducts.map((item: any, i: number) => (
            <li key={i}>
              <a
                style={{ cursor: "pointer" }}
                className="category"
                id={`category-${i + 1}`}
                onClick={() => handleClick(item.key, i + 1)}
              >
                {item.name}
              </a>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default ShopFilter;
