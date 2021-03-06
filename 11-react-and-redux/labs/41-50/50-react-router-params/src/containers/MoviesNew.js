import React, { Component } from 'react';
import { connect } from 'react-redux';
import { addMovie } from '../actions';

class MoviesNew extends Component {

  constructor() {
    super();

    this.state = {
      title: ''
    };
  }

  handleOnSubmit = event => {
    event.preventDefault();
    // this.props.addMovie(this.state);
    // this.props.history.push('/movies');

    // OR destructure history and addMovie from props
    const { addMovie, history } = this.props;
    addMovie(this.state);
    history.push('/movies'); // redirect to '/movies' route
  }

  handleOnChange = event => {
    this.setState({
      title: event.target.value
    });
  }

  render(){
    return (
      <form style={{ marginTop: '16px' }} onSubmit={this.handleOnSubmit} >
        <input 
          type="text" 
          onChange={this.handleOnChange} 
          placeholder="Add a Movie" />
        <input type="submit" value="Add Movie" />
      </form>
    );
  }
}

export default connect(null, { addMovie })(MoviesNew)
