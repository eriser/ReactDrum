import React, {Component} from 'react';
import {
  Text,
  View,
  ScrollView,
  TouchableOpacity,
  StyleSheet
} from 'react-native';

export default class PushedScreen extends Component {
  static navigatorStyle = {
    drawUnderTabBar: true,
    navBarBackgroundColor: '#888888',
    navBarTextColor: '#ffffff',
    navBarSubtitleTextColor: '#ff0000',
    navBarButtonColor: '#ffffff',
    navigationBarColor: '#888888', // for Android ...
  };
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={ this.onPushPress.bind(this) }>
          <Text style={styles.button}>Push Plain Screen</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={ this.onPushStyledPress.bind(this) }>
          <Text style={styles.button}>Push Styled Screen</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={ this.onPopPress.bind(this) }>
          <Text style={styles.button}>Pop Screen</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={ this.onPopToRootPress.bind(this) }>
          <Text style={styles.button}>Pop To Root</Text>
        </TouchableOpacity>
      </View>
    );
  }
  onPushPress() {
    this.props.navigator.push({
      title: "More",
      screen: "reactDrum.PushedScreen"
    });
  }
  onPushStyledPress() {
    this.props.navigator.push({
      title: "More",
      screen: "reactDrum.StyledScreen"
    });
  }
  onPopPress() {
    this.props.navigator.pop();
  }
  onPopToRootPress() {
    this.props.navigator.popToRoot();
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: 'white'
  },
  button: {
    textAlign: 'center',
    fontSize: 18,
    marginBottom: 10,
    marginTop:10,
    color: 'blue'
  }
});
