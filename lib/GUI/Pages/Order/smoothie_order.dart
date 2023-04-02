

/// Represents a smoothie order that includes a smoothie, size, and a vector of addons.
class smoothie_order
{
  /// The type of smoothie.
  String smoothie;

  /// The size of the smoothie.
  String Size;

  /// Any additional addons added to the smoothie.
  List<String> Addons = [];

  /// The index of the table where the order is being placed.
  int table_index = 0;

  /// * Constructs a SmoothieOrder object with the given smoothie name and sets the size to "Medium".
  /// @param smoothie_name the name of the smoothie
  smoothie_order({required this.smoothie, required this.Size});

  /// * Sets the name of the smoothie order
  /// @param smoothie_size the size of the smoothie
  void setSmoothieName(String name)
  {
    smoothie = name;
  }

  /// * Sets the size of the smoothie order to the given size.
  /// @param smoothie_size the size of the smoothie
  void setSmoothieSize(String smoothie_size)
  {
    Size = smoothie_size;
  }

  /// Adds the given addon to the smoothie order.
  /// @param addon_name the name of the addon
  void addAddon(String addon_name)
  {
    Addons.add(addon_name);
  }

  /// * Returns a string representation of the smoothie and size.
  /// @return the smoothie and size
  String getSmoothie()
  {
    return ("$smoothie $Size");
  }

  String getName()
  {
    return smoothie;
  }

  String getSize()
  {
    return Size;
  }

  /// * Returns a vector of the addons in the smoothie order.
  /// @return the addons in the smoothie order
  List<String> getAddons()
  {
    return Addons;
  }

  ///Sets the table index of the smoothie order to the specified value.
  ///@param index the table index to set for the smoothie order
  void setTableIndex(int index) {
    table_index = index;
  }

  ///Gets the table index of the smoothie order.
  ///@return the table index of the smoothie order

  int getTableIndex() {
    return table_index;
  }
}
