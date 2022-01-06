# frozen_string_literal: true

ICONS = {
  '事業設計工学' => '<span class="material-icons">build</span>',
  '情報アーキテクチャ' => '<span class="material-icons">computer</span>',
  '創造技術' => '<span class="material-icons">business</span>'
}.freeze

module ApplicationHelper
  # コースに対応するアイコンを返す
  def major_subject_icon(major_subject_name)
    ICONS[major_subject_name]
  end
end
