export const moneyFormater = (money: number) => {
  if (!money) money = 0;
  return money.toLocaleString("it-IT", { style: "currency", currency: "VND" });
};
