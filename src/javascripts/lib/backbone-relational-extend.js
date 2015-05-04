Backbone.RelationalModel.prototype.set = function( key, value, options ) {
  Backbone.Relational.eventQueue.block();

  // Duplicate backbone's behavior to allow separate key/value parameters, instead of a single 'attributes' object
  var attributes;
  if ( _.isObject( key ) || key == null ) {
    attributes = key;
    options = value;
  }
  else {
    attributes = {};
    attributes[ key ] = value;
  }

  try {
    var id = this.id,
      newId = attributes && this.idAttribute in attributes && attributes[ this.idAttribute ];

    // Check if we're not setting a duplicate id before actually calling `set`.
    //Backbone.Relational.store.checkId( this, newId ); remove to avoid errors in console. JK set is intelligent enough to know when he have to add or not the model

    var result = Backbone.Model.prototype.set.apply( this, arguments );

    // Ideal place to set up relations, if this is the first time we're here for this model
    if ( !this._isInitialized && !this.isLocked() ) {
      this.constructor.initializeModelHierarchy();
      Backbone.Relational.store.register( this );
      this.initializeRelations( options );
    }
    // The store should know about an `id` update asap
    else if ( newId && newId !== id ) {
      Backbone.Relational.store.update( this );
    }

    if ( attributes ) {
      this.updateRelations( attributes, options );
    }
  }
  finally {
    // Try to run the global queue holding external events
    Backbone.Relational.eventQueue.unblock();
  }
  return result;
}

