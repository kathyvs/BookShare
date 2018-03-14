import React from "react"
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';

class BookShareTable extends React.Component {

  convertDataObj(converters, obj) {
    const result = Object.assign({}, obj);
    result.book = obj[this.props.book];
    converters.forEach((converter) => {
      result[converter.dataField] = converter.extractBy(obj);
    });
    return result;
  }

  processColumns(columns) {
    const idColumn = {
      dataField: 'book.key',
      text: 'Ignored',
      hidden: true
    };
    const result = {
      converters: [],
      columns: []
    };
    columns.forEach((column) => {
      const newColumn = Object.assign({}, column);
      newColumn.headerAttrs = newColumn.headerAttrs || {};
      newColumn.headerAttrs.scope = 'col';
      if ('extractBy' in column) {
        delete newColumn.extractBy;
        result.converters.push({extractBy: column.extractBy, dataField: column.dataField})
      }
      result.columns.push(newColumn);
    });
    result.columns.push(idColumn);
    return result;
  }

  render() {
    const processedColumns = this.processColumns(this.props.columns);
    const data = this.props.data.map((obj) => this.convertDataObj(processedColumns.converters, obj));
    return(<BootstrapTable
        keyField='book.key'
        data={data}
        columns = {processedColumns.columns}
      />);
  }
}

BookShareTable.propTypes = {
  caption: PropTypes.string.isRequired,
  book: PropTypes.string.isRequired,
  data: PropTypes.array.isRequired
};

export const utils = {

  bookDescription: function(book) {
    const title = <span className="title">{book.title}</span>;
    const shortName = book.short_name && <span className="short-name">[{book.short_name}]</span>;
    return(<span>{title} {shortName}</span>);
  }
}
export default BookShareTable;
