import React from "react";
const Subcribe = () => {
  return (
    <div>
      <section className="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
        <div className="container py-4">
          <div className="row d-flex justify-content-center py-5">
            <div className="col-md-6">
              <h2 className="mb-0">Subcribe to our Product</h2>
              <span>
                Get e-mail updates about our latest shops and special offers
              </span>
            </div>
            <div className="col-md-6 d-flex align-items-center">
              <form action="#" className="subscribe-form">
                <div className="form-group d-flex">
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Enter email address"
                  />
                  <button type="submit" className="submit px-3">
                    Subscribe
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Subcribe;
