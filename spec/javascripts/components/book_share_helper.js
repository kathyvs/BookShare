
export function findColumn(columnList, dataFieldName) {
  const result = columnList.filter((column) => column.dataField == dataFieldName);
  if (result.length !== 1) {
    console.log('Unable to find ' + dataFieldName + ' in ' + columnList.map((c) => c.dataField));
    expect(result.length).toBe(1);
  }
  return result[0];
}
