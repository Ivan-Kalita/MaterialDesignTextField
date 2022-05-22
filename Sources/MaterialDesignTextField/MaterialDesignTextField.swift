//
//  MaterialDesignTextField.swift
//  Created by Nikita Lazarev-Zubov on 20.5.2022.
//

import SwiftUI

/// A Material Design inspired text field with an animated border and placeholder.
///
/// See <https://m3.material.io/components/text-fields/overview>
public struct MaterialDesignTextField: View {
	
	// MARK: - Properties
	
	// MARK: View protocol properties
	
	public var body: some View {
		ZStack {
			TextField("", text: $text)
				.padding(6.0)
				.background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
					.stroke(borderColor, lineWidth: borderWidth))
				.focused($focusField, equals: .textField)
			HStack {
				ZStack {
					Color(.white)
						.cornerRadius(4.0)
						.opacity(placeholderBackgroundOpacity)
					Text(placeholder)
						.foregroundColor(.white)
						.colorMultiply(placeholderColor)
						.animatableFont(size: placeholderFontSize)
						.padding(2.0)
						.layoutPriority(1)
				}
					.padding([.leading], placeholderLeadingPadding)
					.padding([.bottom], placeholderBottomPadding)
				Spacer()
			}
			HStack {
				VStack {
					Spacer()
					Text(hint)
						.font(.system(size: 10.0))
						.foregroundColor(.gray)
						.padding([.leading], 10.0)
				}
				Spacer()
			}
		}
			.onChange(of: editing) {
				focusField = $0
					? .textField
					: nil
				withAnimation(.easeOut(duration: 0.1)) {
					updateBorder()
					updatePlaceholder()
				}
			}
			.frame(width: .infinity, height: 64.0)
	}
	
	// MARK: Private properties
	
	private let placeholder: String
	@State
	private var borderColor = Color.gray
	@State
	private var borderWidth = 1.0
	@Binding
	private var editing: Bool
	@FocusState
	private var focusField: Field?
	@Binding
	private var hint: String
	@State
	private var placeholderBackgroundOpacity = 0.0
	@State
	private var placeholderBottomPadding = 0.0
	@State
	private var placeholderColor = Color.gray
	@State
	private var placeholderFontSize = 16.0
	@State
	private var placeholderLeadingPadding = 2.0
	@Binding
	private var text: String
	@Binding
	private var valid: Bool
	
	// MARK: - Initialization
	
	/// Creates a Material Design inspired text field with an animated border and placeholder.
	/// - Parameters:
	///   - text: The text field contents.
	///   - placeholder: The placeholder string.
	///   - hint: The field hint string.
	///   - editing: Whether the field is in the editing state.
	///   - valid: Whether the field is in the valid state.
	init(_ text: Binding<String>,
		 placeholder: String,
		 hint: Binding<String>,
		 editing: Binding<Bool>,
		 valid: Binding<Bool>) {
		self._text = text
		self.placeholder = placeholder
		self._hint = hint
		self._editing = editing
		self._valid = valid
	}
	
	// MARK: - Methods
	
	// MARK: Private methods
	
	private func updateBorder() {
		updateBorderColor()
		updateBorderWidth()
	}
	
	private func updateBorderColor() {
		if !valid {
			borderColor = .red
		} else if editing {
			borderColor = .blue
		} else {
			borderColor = .gray
		}
	}
	
	private func updateBorderWidth() {
		borderWidth = editing
			? 2.0
			: 1.0
	}
	
	private func updatePlaceholder() {
		updatePlaceholderBackground()
		updatePlaceholderColor()
		updatePlaceholderFontSize()
		updatePlaceholderPosition()
	}
	
	private func updatePlaceholderBackground() {
		if editing
			|| !text.isEmpty {
			placeholderBackgroundOpacity = 1.0
		} else {
			placeholderBackgroundOpacity = 0.0
		}
	}
	
	private func updatePlaceholderColor() {
		if valid {
			placeholderColor = editing
				? .blue
				: .gray
		} else if text.isEmpty {
			placeholderColor = editing
				? .red
				: .gray
		} else {
			placeholderColor = .red
		}
		
	}
	
	private func updatePlaceholderFontSize() {
		if editing
			|| !text.isEmpty {
			placeholderFontSize = 10.0
		} else {
			placeholderFontSize = 16.0
		}
	}
	
	private func updatePlaceholderPosition() {
		if editing
			|| !text.isEmpty {
			placeholderBottomPadding = 34.0
			placeholderLeadingPadding = 8.0
		} else {
			placeholderBottomPadding = 0.0
			placeholderLeadingPadding = 8.0
		}
	}
	
	// MARK: -
	
	private enum Field {
		
		case textField
		
	}
	
}
